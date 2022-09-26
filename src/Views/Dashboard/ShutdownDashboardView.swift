//
//  SwiftUIView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/19/22.
//

import SwiftUI

struct ShutdownDashboardView: View {
    @EnvironmentObject var env: AppEnv
    var body: some View {
        VStack {
            StatusBarView()
            ZStack {
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.95))
                ShutdownMessageView().padding()
            }
            .padding()
            
                
            HStack {
                Button("Restart Klipper Service") {
                    env.configuredPrinters[env.selectedPrinterIndex].klipperServiceRestart()
                }
                .buttonStyle(.bordered)
                Button("Restart Host") {
                    env.configuredPrinters[env.selectedPrinterIndex].hostRestart()
                }
                .buttonStyle(.bordered)
                Button("Firmware Restart") {
                    env.configuredPrinters[env.selectedPrinterIndex].firmwareRestart()
                }
                .buttonStyle(.borderedProminent)
            }.padding()
            Spacer()

        }
    }
}

struct ShutdownDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ShutdownDashboardView()
            .environmentObject(AppEnv())
    }
}

struct ShutdownMessageView: View {
    @EnvironmentObject var env: AppEnv
    
    var body: some View {
        Text(env.configuredPrinters[env.selectedPrinterIndex].shutdownMessage )
    }
}
