//
//  MainView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var env: AppEnv
    @State var isPresentingEditSheet = false
    
    var body: some View {
        TabView {
            if (env.configuredPrinters[env.selectedPrinterIndex].isConnected && !env.configuredPrinters[env.selectedPrinterIndex].isShutdown) {
                ReadyDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            } else if (env.configuredPrinters[env.selectedPrinterIndex].isShutdown && env.configuredPrinters[env.selectedPrinterIndex].isConnected) {
                ShutdownDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            } else {
                DisconnectedDashboardView()
                    .tabItem { Label("Dashboard", systemImage: "speedometer") }
            }
                        NavigationView {
                            PrintersView(closer: {isPresentingEditSheet = false}, opener: {isPresentingEditSheet = true})
            }.tabItem { Label("Printers", systemImage: "printer") }
                .sheet(isPresented: $isPresentingEditSheet) {
                EditSheetView(closer: {isPresentingEditSheet = false})
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView().environmentObject(AppEnv())
            MainView().previewDevice("iPhone SE (3rd generation)").environmentObject(AppEnv())
        }
    }
}


