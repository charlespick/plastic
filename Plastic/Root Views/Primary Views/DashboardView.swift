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
                DashboardJoggingControlsView(viewModel: .init())
                Text("Extruder Controls")
                Text("Temps")
                Text("Misc controls")
                Text("Macros")
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}
