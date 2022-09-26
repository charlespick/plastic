//
//  EditSheetView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/24/22.
//

import SwiftUI

struct EditSheetView: View {
    @EnvironmentObject var env: AppEnv
    var closer: () -> Void
    
    init( closer: @escaping () -> Void ) {
        self.closer = closer
    }
    
    var body: some View {
        NavigationView {
            PrinterEditView()
            .toolbar() {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        closer()
                        env.tempData = Printer.ModifiedData()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if (env.tempData.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                            
                            return
                        }
                        closer()
                        if (env.isInEditMode){
                            env.printerBeingEdited = Printer(data: env.tempData)
                            closer()
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

struct EditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditSheetView()
    }
}
