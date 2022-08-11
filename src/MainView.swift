//
//  MainView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct MainView: View {
    @State private var isPresentingEditSheet = false
    @State private var newPrinterData = PrinterConfig.ModifiedData()
    @State private var isInEditMode = false
    @State private var printerBeingEdited = -1
    
    @ObservedObject var printer: PrinterConnection
    
    @Binding var printers: [PrinterConfig]
    
    let saveCallForPrinters: ()->Void
    let selectActionForPrinters: (UUID) -> Void
    
    var body: some View {
        TabView {
            DashboardView(printer: printer).tabItem { Label("Dashboard", systemImage: "speedometer") }
            NavigationView {
                PrintersView(printers: $printers, isPresentingEditSheet: $isPresentingEditSheet, isInEditMode: $isInEditMode, newPrinterData: $newPrinterData, printerBeingEdited: $printerBeingEdited, saveCall: saveCallForPrinters, selectAction: selectActionForPrinters)
            }.tabItem { Label("Printers", systemImage: "printer") }
            .sheet(isPresented: $isPresentingEditSheet) {
                EditSheetView(newPrinterData: $newPrinterData, isInEditMode: $isInEditMode, isPresentingEditSheet: $isPresentingEditSheet, printerBeingEdited: $printerBeingEdited, printers: $printers)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(printer: PrinterConnection(), printers: .constant(PrinterConfig.sampleData), saveCallForPrinters: {}, selectActionForPrinters: {_ in })
    }
}

struct EditSheetView: View {
    @Binding var newPrinterData: PrinterConfig.ModifiedData
    @Binding var isInEditMode: Bool
    @Binding var isPresentingEditSheet: Bool
    @Binding var printerBeingEdited: Int
    @Binding var printers: [PrinterConfig]

    var body: some View {
        NavigationView {
            PrinterEditView(data: $newPrinterData, isInEditMode: $isInEditMode, deleteCall: {
                printers.remove(at: printerBeingEdited)
                isPresentingEditSheet = false
            })
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresentingEditSheet = false
                        newPrinterData = PrinterConfig.ModifiedData()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if (newPrinterData.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                            
                            return
                        }
                        
                        isPresentingEditSheet = false
                        if (isInEditMode){
                            printers.remove(at: printerBeingEdited)
                            printers.insert(PrinterConfig(data: newPrinterData), at: printerBeingEdited)
                            isInEditMode = false
                        } else {
                            printers.append(PrinterConfig(data: newPrinterData))
                            newPrinterData = PrinterConfig.ModifiedData()
                        }
                        
                    }
                }
            }
            .navigationTitle(isInEditMode ? "Edit Printer":"Add Printer")
        }
    }
}

