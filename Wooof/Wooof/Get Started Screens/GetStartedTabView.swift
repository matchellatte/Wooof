


import SwiftUI

struct GetStartedTabView: View {
    var body: some View {
        TabView {
            GetStartedScreen1()
                .tag(0)
            GetStartedScreen2()
                .tag(1)
            GetStartedScreen3()
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

// Preview
struct GetStartedTabView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedTabView()
    }
}



