//
//  entriesList.swift
//  journal_app
//
//  Created by Jacob Sheiner on 6/11/24.
//
import SwiftUI
import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    let text: String
    let color: Color
    let date: Date
    let name: String
    
}

class JournalEntryList: ObservableObject {
    static let shared = JournalEntryList()
    
    private init() {}
    
    @Published var myArray: [JournalEntry] = [first,second,third]
    
    func addObject(_ object: JournalEntry) {
        myArray.insert(object, at: 0)
    }
    
    func removeObject(withID id: UUID) {
        myArray.removeAll { $0.id == id }
    }
    
    func removeObject(withName name: String) {
        myArray.removeAll { $0.text == name }
    }
    
    
}
let first = JournalEntry(text:"first",color: .red,date:Date(),name:"name")
let second = JournalEntry(text:"second",color: .yellow,date:Date(),name:"namerino")
let third = JournalEntry(text:"third",color: .blue,date: Date(),name:"namesky")
