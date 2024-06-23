//
//  OpenAIViewModel.swift
//  journal_app
//
//  Created by Jacob Sheiner on 6/12/24.
//

import Foundation
import Combine
import SwiftUI

class OpenAIViewModel: ObservableObject {
    @ObservedObject private var journalEntryList = JournalEntryList.shared
    @Published var userInput: String = ""
    @Published var responseText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    //make http request
    func fetchResponse(completion: @escaping () -> Void) { //check completion
        guard !userInput.isEmpty else { return }
        
        
        //private key (secret!!!)
        let apiKey = [YOUR_API_KEY_HERE]
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        
        //API parameters
        let parameters: [String: Any] = [
            "model": "gpt-4-turbo",
            "messages": [["role": "user", "content": "return a color basd on the mood of the following text.The color should be as nuanced as possible, it should be very rare taht two inputs yield the same color. The color should be as iconic as possible, people should be able to get a sense of the mood just by seeing the color, even without the text. Also return a name for the chosen color. Also return a very brief explanation of why the color was chosen. The explanation should be about one sentence, and should avoid quoting the user input directly, in favor of describing emotions and moods. The response must be decodable by a JSON decoder with parameters color, name, and explanation.input text:\(userInput)"]],
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
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error.localizedDescription)")
                    self.responseText = "Error: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] response in
                self?.responseText = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "No response"
                completion()    //check for completion
            })
            .store(in: &cancellables)
        
    }
    
    
    //decode response
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
    //response decoder
    struct MoodResponse: Codable {
        let color: String
        let explanation: String
        let name: String
    }
    
    //the current call returns a JSON file as the message, decode the nested JSON (hex code and explanation)
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
   
    
    //add the user input and color to the global array
    func uploadResponse(){
        if let responseData = responseText.data(using: .utf8) {
            if let moodResponse = decodeMoodResponse(from: responseData) {
                let entry = JournalEntry(text:userInput,color: Color(hex: moodResponse.color),date: Date(),name:moodResponse.name,expl:moodResponse.explanation)
                journalEntryList.addObject(entry)
            }
        }
    }
    
    
    
    
}
