import SwiftUI
import Foundation

struct JournalEntry: Identifiable, Codable {
    let id: UUID
    let text: String
    let color: CodableColor
    let date: Date
    let name: String
    let expl: String
    let imagePath: String?

    init(id: UUID = UUID(), text: String, color: Color, date: Date, name: String, expl: String, imagePath: String? = nil) {
        self.id = id
        self.text = text
        self.color = CodableColor(color: color)
        self.date = date
        self.name = name
        self.expl = expl
        self.imagePath = imagePath
    }
}

struct CodableColor: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let opacity: CGFloat

    init(color: Color) {
        if let cgColor = color.cgColor {
            self.red = cgColor.components?[0] ?? 0
            self.green = cgColor.components?[1] ?? 0
            self.blue = cgColor.components?[2] ?? 0
            self.opacity = cgColor.alpha
        } else {
            self.red = 0
            self.green = 0
            self.blue = 0
            self.opacity = 0
        }
    }

    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}

class JournalEntryList: ObservableObject {
    static let shared = JournalEntryList()

    private let userDefaultsKey = "JournalEntries"
    
    private init() {
        loadFromUserDefaults()
    }

    @Published var myArray: [JournalEntry] = [first, second, third, fourth] {
        didSet {
            saveToUserDefaults()
        }
    }

    func addObject(_ object: JournalEntry) {
        myArray.insert(object, at: 0)
    }

    func removeObject(withID id: UUID) {
        myArray.removeAll { $0.id == id }
    }

    func removeObject(withName name: String) {
        myArray.removeAll { $0.name == name }
    }

    func indexOfEntry(withID id: UUID) -> Int? {
        return myArray.firstIndex { $0.id == id }
    }
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(myArray) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    private func loadFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedArray = try? JSONDecoder().decode([JournalEntry].self, from: savedData) {
            myArray = decodedArray
        }
    }
}

let first = JournalEntry(text: "first", color: Color(hex: "ff5500"), date: Date(), name: "name", expl: "", imagePath: nil)
let second = JournalEntry(text: "second", color: Color(hex: "ffff22"), date: Date(), name: "namerino", expl: "", imagePath: nil)
let third = JournalEntry(text: "third", color: Color(hex: "0055ff"), date: Date(), name: "namesky", expl: "", imagePath: nil)
let fourth = JournalEntry(text: "fourth", color: Color(hex: "0890ff"), date: Date(), name: "namesky", expl: "", imagePath: nil)
