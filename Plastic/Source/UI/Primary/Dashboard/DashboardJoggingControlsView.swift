import SwiftUI

struct DashboardJoggingControlsView: View {
    @StateObject var viewModel: DashboardJoggingControlsViewModel
    
    var body: some View {
        VStack {
            ToolheadPositionView()
                .padding([.top, .leading, .trailing])
            JoggingButtonsView()
                .padding([.leading, .bottom, .trailing])
            ToolheadValueSliderView(name: "Speed")
                .padding(.horizontal)
            ToolheadValueSliderView(name: "Distance")
                .padding(.horizontal)
        }.background(.white)
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
                JoggingButtonView({}, withIcon: "ellipsis", isProminent: false)
                JoggingButtonView({}, withIcon: "chevron.up.circle")
                JoggingButtonView({}, withIcon: "house", isProminent: false)
                JoggingButtonView({}, withIcon: "chevron.up.circle")
            }
            HStack {
                JoggingButtonView({}, withIcon: "chevron.left.circle")
                JoggingButtonView({}, withIcon: "chevron.down.circle")
                JoggingButtonView({}, withIcon: "chevron.right.circle")
                JoggingButtonView({}, withIcon: "chevron.down.circle")
            }
        }
    }
}

struct ToolheadPositionDisplayView: View {
    let name: String
    @Binding var textOut: String
    
    var body: some View {
        VStack {
            Text(name)
            TextField(name, text: $textOut)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct ToolheadPositionView: View {
    @State var xPos: String = "50.4"
    @State var yPos: String = "159.3"
    @State var zPos: String = "20.8"
    
    var body: some View {
        HStack {
            ToolheadPositionDisplayView(name: "X", textOut: $xPos)
            ToolheadPositionDisplayView(name: "Y", textOut: $yPos)
            ToolheadPositionDisplayView(name: "Z", textOut: $zPos)
        }
    }
}

struct ToolheadValueSliderView: View {
    let name: String
    @State var value: Int = 0
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(value)
        }, set: {
            print($0.description)
            value = Int($0)
        })
    }
    var body: some View {
        HStack{
            Text(name)
            Text(value.description)
            Slider(value: intProxy , in: 5.0...100.0, step: 1.0, onEditingChanged: {_ in
                print(value.description)
            })
        }
    }
}

