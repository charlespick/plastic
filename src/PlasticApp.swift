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
    @State private var printers = Printer.sampleData

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PrintersView(printers: $printers)
            }
        }
    }
}

struct Macro: Identifiable {
    var id: Int
    let name: String
}
