import SwiftUI

struct FilesView: View {
    @StateObject var viewModel: FilesViewModel
    
    var body: some View {
        Text("A File Explorer")
    }
}

struct FilesView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView(viewModel: .init())
    }
}
