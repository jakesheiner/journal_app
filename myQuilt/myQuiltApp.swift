//
//  journal_appApp.swift
//  journal_app
//
//  Created by Jacob Sheiner on 6/8/24.
//

import SwiftUI
import SwiftData

@main
struct journal_appApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            
            CustomTabView()
           

        }
        .modelContainer(sharedModelContainer)
    }
}
