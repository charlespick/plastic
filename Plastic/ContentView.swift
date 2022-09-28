//
//  ContentView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/27/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView(viewModel: .init()).tabItem { Label("Dashboard", systemImage: "desktopcomputer") }
            MachineSettingsView(viewModel: .init()).tabItem { Label("Machine Settings", systemImage: "gearshape.2") }
            Text("Files").tabItem { Label("Files", systemImage: "folder") }
            Text("History").tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
            Text("Printers").tabItem { Label("Printers", systemImage: "printer") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
