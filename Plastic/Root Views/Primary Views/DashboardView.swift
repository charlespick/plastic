//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/27/22.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack {
            DashboardStatusBarView(viewModel: .init())
            ScrollView{
                Image("ExampleWebcam")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, idealHeight: 300)
                    .clipped()
                Label("Toolhead", systemImage: "grid")
                    .padding(.top)
                    .font(.caption2)
                DashboardJoggingControlsView(viewModel: .init())
                    .cornerRadius(16)
                    .padding([.top, .leading, .trailing], 16)
                    .padding(.top, -18.0)
                Label("Extruder", systemImage: "point.topleft.down.curvedto.point.bottomright.up.fill")
                    .padding(.top)
                    .font(.caption2)
                DashboardExtruderControlsView(viewModel: .init())
                    .cornerRadius(16)
                    .padding([.leading, .bottom, .trailing], 16)
                Text("Temps")
                Text("Misc controls")
                Text("Macros")
            }
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.954))
                .padding(.top, -8.0)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}
