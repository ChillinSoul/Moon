//
//  MoonApp.swift
//  Moon
//
//  Created by Axel Bergiers on 21/04/2024.
//

import SwiftUI
import SwiftData

@main
struct MoonApp: App {
    @StateObject var graphQLClient = GraphQLClient()
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    

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
            if isAuthenticated {
                ClientsView()
                    .environmentObject(graphQLClient)
            } else {
                LoginView(graphQLClient: graphQLClient, isAuthenticated: $isAuthenticated)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
