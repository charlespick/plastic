//
//  ContentView.swift
//  Shared between iOS and macOS
//  Main View
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            PrinterScreenView().tabItem { Text("Printer") }.tag(1)
            JobsScreenView().tabItem { Text("Jobs") }.tag(2)
            TuningScreenView().tabItem { Text("Tuning") }.tag(3)
            ConsoleScreenView().tabItem { Text("Console") }.tag(4)
            SystemScreenView().tabItem { Text("System") }.tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
