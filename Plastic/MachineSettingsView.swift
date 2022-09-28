//
//  MachineSettingsView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/27/22.
//

import SwiftUI

struct MachineSettingsView: View {
    @StateObject var viewModel: MachineSettingsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MachineSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MachineSettingsView(viewModel: .init())
    }
}
