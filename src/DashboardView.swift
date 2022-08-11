//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var printer: PrinterConnection
    
    var body: some View {
        Text(printer.configuredName)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(printer: PrinterConnection(name: "Voron", alive: true))
    }
}
