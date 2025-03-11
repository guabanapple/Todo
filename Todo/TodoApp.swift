//
//  TodoApp.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/08.
//

import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    var sharedModelContainer: ModelContainer {
        let schema = Schema([TodoItem.self])
        let modelConfigration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfigration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
