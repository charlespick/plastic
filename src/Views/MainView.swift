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

struct EditSheetView: View {
    @EnvironmentObject var env: AppEnv

    var body: some View {
        NavigationView {
            PrinterEditView()
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        env.isPresentingEditSheet = false
                        env.tempData = Printer.ModifiedData()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if (env.tempData.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                            
                            return
                        }
                        env.isPresentingEditSheet = false
                        if (env.isInEditMode){
                            env.printerBeingEdited = Printer(data: env.tempData)
                            env.isInEditMode = false
                        } else {
                            env.configuredPrinters.append(Printer(data: env.tempData))
                            env.tempData = Printer.ModifiedData()
                        }
                        
                    }
                }
            }
            .navigationTitle(env.isInEditMode ? "Edit Printer":"Add Printer")
        }
    }
}

