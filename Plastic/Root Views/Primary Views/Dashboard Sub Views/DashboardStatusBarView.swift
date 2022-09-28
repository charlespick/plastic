//
//  DashboardStatusBarView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/28/22.
//

import SwiftUI

struct DashboardStatusBarView: View {
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Voron")
                Text("Printer Ready")
                    .font(.headline)
            }
            .padding(.vertical)
            .foregroundColor(.white)
            Spacer()
        }.background(.green)
    }
}

struct DashboardStatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}
