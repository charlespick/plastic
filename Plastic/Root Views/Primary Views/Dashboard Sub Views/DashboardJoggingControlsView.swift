//
//  DashboardJoggingControlsView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/28/22.
//

import SwiftUI

struct DashboardJoggingControlsView: View {
    @StateObject var viewModel: DashboardJoggingControlsViewModel
    
    var body: some View {
        JoggingButtonsView()
    }
}

struct DashboardJoggingControlsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}

struct JoggingButtonView: View {
    let whenPressed: () -> ()
    let systemNameForIcon: String
    let isProminent: Bool
    
    init(_ whenPressed: @escaping () -> Void, withIcon systemNameForIcon: String, isProminent: Bool = true) {
        self.whenPressed = whenPressed
        self.systemNameForIcon = systemNameForIcon
        self.isProminent = isProminent
    }
    
    var body: some View {
        if (isProminent) {
            Button(action: whenPressed) {
                Image(systemName: systemNameForIcon)
                    .frame(maxWidth: .infinity, minHeight: 40   )
            }
            .buttonStyle( .borderedProminent )
        } else {
            Button(action: whenPressed) {
                Image(systemName: systemNameForIcon)
                    .frame(maxWidth: .infinity, minHeight: 40   )
            }
            .buttonStyle( .bordered )
        }
        
    }
}

struct JoggingButtonsView: View {
    var body: some View {
        VStack {
            HStack{
                JoggingButtonView({}, withIcon: "chevron.up.circle", isProminent: false)
                JoggingButtonView({}, withIcon: "chevron.up.circle")
                JoggingButtonView({}, withIcon: "chevron.up.circle", isProminent: false)
                JoggingButtonView({}, withIcon: "chevron.up.circle")
            }
            HStack {
                JoggingButtonView({}, withIcon: "chevron.up.circle")
                JoggingButtonView({}, withIcon: "chevron.up.circle")
                JoggingButtonView({}, withIcon: "chevron.up.circle")
                JoggingButtonView({}, withIcon: "chevron.up.circle")
            }
        }.padding()
    }
}
