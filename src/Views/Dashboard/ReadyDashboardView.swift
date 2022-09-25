//
//  ReadyDashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/19/22.
//

import SwiftUI

struct ReadyDashboardView: View {
    @EnvironmentObject var env: AppEnv

    var body: some View {
        VStack {
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            ToolheadView()
            Divider()
            TemperatureButtonView().padding(.horizontal)
            
            MacrosView()
            Spacer()
        }
    }
}

struct JoggingControlsView: View {
    let height = 50.0
    let width = 60.0
    @State var moveSpeed: Float = 10
    @State var moveDist: Float = 10
    @EnvironmentObject var env: AppEnv
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    JogButtonView(systemName: "ellipsis", prominent: false) {
                        env.selectedPrinter?.eStop()
                    }
                    JogButtonView(systemName: "arrow.up.circle", prominent: true, action: {})
                    JogButtonView(systemName: "house", prominent: false, action: {})
                    JogButtonView(systemName: "arrow.up.circle", prominent: true, action: {})
                }
                HStack{
                    JogButtonView(systemName: "arrow.left.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.down.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.right.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.down.circle", prominent: true, action: {})
                }
            }.padding()
                        
            VStack{
                HStack{
                    Text("Speed").font(.caption2).padding(.top, 2.0).frame(width: 60.0)
                    Picker("Speed", selection: $moveSpeed){
                        Text(String(10))
                        Text(String(20))
                    }
                    .pickerStyle(.segmented)
                }.padding(.horizontal)
                HStack{
                    Text("Distance").font(.caption2).padding(.top, 2.0).frame(width: 60.0)
                    Picker("Distance", selection: $moveDist){
                        Text(String(10))
                        Text(String(20))
                        Text(String(30))
                    }
                    .pickerStyle(.segmented)
                }.padding(.horizontal)
            }
            
        }
    }
}

struct JogButtonView: View {
    let systemName: String
    let prominent: Bool
    let height = 40.0
    let action: ()->()
    
    var body: some View {
        
        if (prominent){
            Button(action: { action() }){
                HStack {
                    Image(systemName: systemName)
                        .frame(maxWidth: .infinity, maxHeight: height)
                }
            }.buttonStyle(.borderedProminent)
        } else {
            Button(action: { action() }){
                HStack {
                    Image(systemName: systemName)
                        .frame(maxWidth: .infinity, maxHeight: height)
                }
            }.buttonStyle(.bordered)
        }
    }
}

struct ReadyDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyDashboardView()
            .environmentObject(AppEnv())
    }
}
