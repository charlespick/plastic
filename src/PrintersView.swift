//
//  PrintersView.swift
//  A view that displays configured printers and allows the user to
//  change the selected printer, add new ones, delete, and edit old ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrintersView: View {
    @Binding var printers: [PrinterConfig]
    @Binding var isPresentingEditSheet: Bool
    @Binding  var isInEditMode: Bool
    @Binding var newPrinterData: PrinterConfig.ModifiedData
    @Binding var printerBeingEdited: Int
    @Environment(\.scenePhase) private var scenePhase
    let saveCall: ()->Void
    let selectAction: (_ printerID: UUID)->Void
    
    var body: some View {
        List{
            ForEach(Array(printers.enumerated()), id: \.element) { index, printer in
                PrinterCardView(printer: printer, selectAction: { printerID in
                    if (!isInEditMode){
                        selectAction(printerID)
                    } else {
                        newPrinterData = printer.modifiedData
                        printerBeingEdited = index
                        isPresentingEditSheet = true
                    }
                    
                }, isInEditMode: isInEditMode)
            }
        }
        .navigationTitle("Printers")
        .toolbar() {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: { isInEditMode.toggle() }) {
                    if (!isInEditMode){ Text("Edit") } else { Text("Done").fontWeight(.medium) } }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newPrinterData = PrinterConfig.ModifiedData()
                    isPresentingEditSheet = true
                    isInEditMode = false }) { Image(systemName: "plus") }
            }
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveCall() }
        }
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(printers: .constant(PrinterConfig.sampleData), isPresentingEditSheet: .constant(false), isInEditMode: .constant(false), newPrinterData: .constant(PrinterConfig.ModifiedData()), printerBeingEdited: .constant(-1), saveCall: {}, selectAction: { printerID in })
        }
    }
}

struct PrinterCardView: View {
    let printer: PrinterConfig
    let selectAction: (_ printerID: UUID)->Void
    let isInEditMode: Bool
    
    var body: some View {
        Button( action: { selectAction(printer.id) } ) {
            HStack{
                if (!isInEditMode){
                    if (printer.renderSelected) {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                }
                Text(printer.name)
            }
        }
    }
}
