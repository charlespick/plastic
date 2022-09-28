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
            Text("Hello, Dashboard!!")
            Text("Status Bar (always on top)")
            Text("Cameras (if any)")
            Text("Jogging Controls")
            Text("Extruder Controls")
            Text("Temps")
            Text("Misc controls")
            Text("Macros")

            
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}
