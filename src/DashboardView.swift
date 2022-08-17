//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        Text(env.selectedPrinter?.name ?? "No Printer Selected")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().environmentObject(PrinterEnv())
    }
}
