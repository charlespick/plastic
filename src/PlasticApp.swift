//
//  PlasticApp.swift
//  App kernal and bearer of app state
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI
import CoreData

@main
struct PlasticApp: App {
    @StateObject private var env = PrinterEnv()
    
    var body: some Scene {
        WindowGroup {
            MainView()
            .onAppear {
                env.load()
            }
            .environmentObject(env)
        }
    }
}
