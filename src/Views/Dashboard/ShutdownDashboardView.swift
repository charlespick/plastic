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
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            ZStack {
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.95))
                ShutdownMessageView(selectedPrinter: env.selectedPrinter ?? Printer(name: "", url: "")).padding()
            }
            .padding()
            
                
            HStack {
                Button("Restart Klipper Service") {
                    env.selectedPrinter?.klipperServiceRestart()
                }
                .buttonStyle(.bordered)
                Button("Restart Host") {
                    env.selectedPrinter?.hostRestart()
                }
                .buttonStyle(.bordered)
                Button("Firmware Restart") {
                    env.selectedPrinter?.firmwareRestart()
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
    @State var selectedPrinter: Printer
    var body: some View {
        Text(selectedPrinter.shutdownMessage ?? "shutdown message")
    }
}
