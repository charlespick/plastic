//
//  MainView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct MainView: View {
    @Binding var printers: [PrinterConfig]
    @State private var isPresentingEditSheet = false
    @State private var newPrinterData = PrinterConfig.ModifiedData()
    @State private var isInEditMode = false
    @State private var printerBeingEdited = -1
    let saveCallForPrinters: ()->Void
    let selectActionForPrinters: (UUID) -> Void
    
    var body: some View {
        TabView {
            NavigationView {
                PrintersView(printers: $printers, isPresentingEditSheet: $isPresentingEditSheet, isInEditMode: $isInEditMode, newPrinterData: $newPrinterData, printerBeingEdited: $printerBeingEdited, saveCall: saveCallForPrinters, selectAction: selectActionForPrinters)
            }.tabItem {
                Label("Printers", systemImage: "printer")
                
            }
            .sheet(isPresented: $isPresentingEditSheet) {
                EditSheetView(newPrinterData: $newPrinterData, isInEditMode: $isInEditMode, isPresentingEditSheet: $isPresentingEditSheet, printerBeingEdited: $printerBeingEdited, printers: $printers)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(printers: .constant(PrinterConfig.sampleData), saveCallForPrinters: {}, selectActionForPrinters: {_ in })
    }
}
