import SwiftUI

struct PrintersView: View {
    @StateObject var viewModel: PrintersViewModel
    
    var body: some View {
        Text("A List of printers")
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        PrintersView(viewModel: .init())
    }
}
