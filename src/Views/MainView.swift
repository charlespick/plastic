//
//  MainView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var env: AppEnv
    @ObservedObject var selectedPrinter: Printer
    
    var body: some View {
        TabView {
            if (selectedPrinter.isConnected && !selectedPrinter.isShutdown) {
                ReadyDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            } else if (selectedPrinter.isShutdown && selectedPrinter.isConnected) {
                ShutdownDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            } else {
                DisconnectedDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            }
                        NavigationView {
                PrintersView()
            }.tabItem { Label("Printers", systemImage: "printer") }
                .sheet(isPresented: $env.isPresentingEditSheet) {
                EditSheetView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(selectedPrinter: Printer(name: "Test Printer", url: "")).environmentObject(AppEnv())
            MainView(selectedPrinter: Printer(name: "Test Printer", url: "")).previewDevice("iPhone SE (3rd generation)").environmentObject(AppEnv())
        }
    }
}


