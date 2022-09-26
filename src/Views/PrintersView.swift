//
//  PrintersView.swift
//  A view that displays configured printers and allows the user to
//  change the selected printer, add new ones, delete, and edit old ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrintersView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var env: AppEnv
    var closer: () -> Void
    var opener: () -> Void
    
    var body: some View {
        List {
            ForEach(env.configuredPrinters) { printer in
                PrinterCardView(printer: printer, closer: closer)
            }
        }
        .navigationTitle("Printers")
        .toolbar() {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    env.isInEditMode.toggle()
                }) { if (!env.isInEditMode) {
                        Text("Edit")
                    } else {
                        Text("Done").fontWeight(.medium)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    env.tempData = Printer.ModifiedData()
                    opener()
                    env.isInEditMode = false }) { Image(systemName: "plus") }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { env.save() }
        }
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(closer: {}, opener: {}).environmentObject(AppEnv())
        }
    }
}

struct PrinterCardView: View {
    let printer: Printer
    @EnvironmentObject var env: AppEnv
    var closer: () -> Void
    
    var body: some View {
        Button( action: {
            if (env.isInEditMode) {
                env.printerBeingEdited = printer
                env.tempData = env.printerBeingEdited?.modifiedData ?? Printer.ModifiedData(name: "Error", url: "Error")
                closer()
            } else {
                env.configuredPrinters[env.selectedPrinterIndex] = printer
                env.configuredPrinters[env.selectedPrinterIndex].connect()
            }})
        {
            HStack{
                if (!env.isInEditMode){
                    if (printer == env.configuredPrinters[env.selectedPrinterIndex] ) {
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
