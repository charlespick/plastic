//
//  PlasticApp.swift
//  Shared between iOS and macOS
//  Head of the app
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

@main
struct PlasticApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct Macro: Identifiable {
    var id: Int
    let name: String
}
