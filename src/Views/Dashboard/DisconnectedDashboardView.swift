//
//  DisconnectedDashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/19/22.
//

import SwiftUI

struct DisconnectedDashboardView: View {
    @EnvironmentObject var env: AppEnv
    
    var body: some View {
        VStack {
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            Spacer()
            Button("Connect") {
                env.selectedPrinter?.connect()
            }
            Spacer()
        }
    }
}

struct DisconnectedDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DisconnectedDashboardView()
            .environmentObject(AppEnv())
    }
}
