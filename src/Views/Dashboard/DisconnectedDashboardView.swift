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
            StatusBarView()
            Spacer()
            Button("Connect") {
                if (env.configuredPrinters[env.selectedPrinterIndex] != nil) {
                    env.configuredPrinters[env.selectedPrinterIndex].connect()
                }
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
