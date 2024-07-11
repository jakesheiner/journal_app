import Foundation
import SwiftUI
import Combine

class OpenAIViewModel: ObservableObject {
    @ObservedObject private var journalEntryList = JournalEntryList.shared
    @Published var userInput: String = ""
    @Published var responseText: String = ""
    @Published var generatedImage: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private let apiKey: String = {
        if let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            return key
        } else {
            fatalError("API Key not found in Info.plist")
        }
    }() // Replace with your actual API key

    func fetchResponseAndImage(completion: @escaping () -> Void) {
        guard !userInput.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "model": "gpt-4-turbo",
            "messages": [["role": "user", "content": "return a color based on the mood of the following text. The color should be as nuanced as possible, it should be very rare that two inputs yield the same color. The color should be as iconic as possible, people should be able to get a sense of the mood just by seeing the color, even without the text. Also return a name for the chosen color. Also return a very brief explanation of why the color was chosen. The explanation should be about one sentence, and should avoid quoting the user input directly, in favor of describing emotions and moods. Also return a prompt for an image generator for an image of a texture that represents the mood of the text. The texture should be flat and uniform, and completely fill the image frame, and should be grayscale. It should resemble a swatch of material. The response must be decodable by a JSON decoder with parameters color, name, explanation and prompt. input text:\(userInput)"]],
            "temperature": 1,
            "response_format": [
                "type": "json_object"
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if httpResponse.statusCode != 200 {
                    let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                    print("Server returned status code \(httpResponse.statusCode): \(errorMessage)")
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: OpenAIChatResponse.self, decoder: JSONDecoder())
            .flatMap { response -> AnyPublisher<UIImage, Error> in
                self.responseText = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "No response"
                
                // Extract prompt
                let prompt = self.decodeMoodResponse(from: Data(self.responseText.utf8))?.prompt
                print(prompt)
                guard let prompt = prompt else {
                    return Fail(error: URLError(.cannotDecodeContentData)).eraseToAnyPublisher()
                }
                
                // Generate image using the explanation
                return self.generateImagePublisher(using:prompt)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }, receiveValue: { image in
                self.generatedImage = image
                self.uploadResponse()
                completion()
            })
            .store(in: &cancellables)
    }

    // Decode response
    struct OpenAIChatResponse: Codable {
        struct Choice: Codable {
            struct Message: Codable {
                let role: String
                let content: String
            }
            let message: Message
        }
        let choices: [Choice]
    }

    struct MoodResponse: Codable {
        let color: String
        let explanation: String
        let name: String
        let prompt: String
    }

    // Decode MoodResponse from JSON data
    func decodeMoodResponse(from jsonData: Data) -> MoodResponse? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(MoodResponse.self, from: jsonData)
            return response
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }

    // Save image to file system and return the file path
    func saveImageToDocuments(image: UIImage) -> String? {
        guard let data = image.pngData() else { return nil }

        let filename = UUID().uuidString + ".png"
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)

        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return nil
        }
    }

    // Add the user input, color, and image to the global array
    func uploadResponse() {
        guard let responseData = responseText.data(using: .utf8),
              let moodResponse = decodeMoodResponse(from: responseData),
              let imagePath = generatedImage.flatMap(saveImageToDocuments) else { return }

        let entry = JournalEntry(id: UUID(), text: userInput, color: Color(hex: moodResponse.color), date: Date(), name: moodResponse.name, expl: moodResponse.explanation, imagePath: imagePath)
        journalEntryList.addObject(entry)
        print(imagePath)
    }

    // Generate image using DALL-E
    private func generateImagePublisher(using prompt: String) -> AnyPublisher<UIImage, Error> {
        let prompt = "\(prompt)"
        let urlString = "https://api.openai.com/v1/images/generations"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "dall-e-3",
            "prompt": prompt,
            "n": 1,
            "size": "1024x1024"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> URL in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let dataArray = json["data"] as? [[String: Any]],
                      let imageUrlString = dataArray.first?["url"] as? String,
                      let imageUrl = URL(string: imageUrlString) else {
                    throw URLError(.cannotParseResponse)
                }
                return imageUrl
            }
            .flatMap { imageUrl in
                URLSession.shared.dataTaskPublisher(for: imageUrl)
                    .tryMap { data, response -> UIImage in
                        guard let image = UIImage(data: data) else {
                            throw URLError(.cannotDecodeContentData)
                        }
                        return image
                    }
            }
            .eraseToAnyPublisher()
    }
}
