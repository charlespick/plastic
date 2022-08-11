//
//  MainView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct MainView: View {
    @State private var isPresentingEditSheet = false
    @State private var newPrinterData = Printer.ModifiedData()
    @State private var isInEditMode = false
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "speedometer") }
            NavigationView {
                PrintersView(isPresentingEditSheet: $isPresentingEditSheet, isInEditMode: $isInEditMode, newPrinterData: $newPrinterData)
            }.tabItem { Label("Printers", systemImage: "printer") }
            .sheet(isPresented: $isPresentingEditSheet) {
                EditSheetView(newPrinterData: $newPrinterData, isInEditMode: $isInEditMode, isPresentingEditSheet: $isPresentingEditSheet)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct EditSheetView: View {
    @Binding var newPrinterData: Printer.ModifiedData
    @Binding var isInEditMode: Bool
    @Binding var isPresentingEditSheet: Bool
    @EnvironmentObject var env: PrinterEnv

    var body: some View {
        NavigationView {
            PrinterEditView(data: $newPrinterData, isInEditMode: $isInEditMode)
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingEditSheet = false
                        newPrinterData = Printer.ModifiedData()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if (newPrinterData.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                            
                            return
                        }
                        
                        isPresentingEditSheet = false
                        if (isInEditMode){
                            env.printerBeingEdited = Printer(data: newPrinterData)
                            isInEditMode = false
                        } else {
                            env.configuredPrinters.append(Printer(data: newPrinterData))
                            newPrinterData = Printer.ModifiedData()
                        }
                        
                    }
                }
            }
            .navigationTitle(isInEditMode ? "Edit Printer":"Add Printer")
        }
    }
}

