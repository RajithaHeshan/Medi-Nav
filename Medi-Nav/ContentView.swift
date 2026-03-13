

//import SwiftUI
//
//struct ContentView: View {
//    @State private var currentTab: AppTab = .home
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            
//            TabView(selection: $currentTab) {
//                
//                NavigationStack {
//                    HomeView()
//                }
//                .tag(AppTab.home)
//                .toolbar(.hidden, for: .tabBar)
//                
//                NavigationStack {
//                    FindDoctorView()
//                }
//                .tag(AppTab.booking)
//                .toolbar(.hidden, for: .tabBar)
//                
//                NavigationStack {
//                    ChatView()
//                }
//                .tag(AppTab.chat)
//                .toolbar(.hidden, for: .tabBar)
//                
//                NavigationStack {
//                    AccountView()
//                }
//                .tag(AppTab.account)
//                .toolbar(.hidden, for: .tabBar)
//            }
//            
//            // 🔴 HIG FIX: zIndex(1) forces this to NEVER be covered by TabView children
//            CustomTabBar(selectedTab: $currentTab)
//                .zIndex(1)
//        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
//    }
//}
//
//#Preview {
//    ContentView()
//}
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: AppTab = .home
    
    // 🔴 HIG FIX: This path controls the "stack" of pages on the Home tab
    @State private var homeNavigationPath = NavigationPath()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                
                // 🔴 HIG FIX: Bind the path to the Home NavigationStack
                NavigationStack(path: $homeNavigationPath) {
                    HomeView()
                }
                .tag(AppTab.home)
                .toolbar(.hidden, for: .tabBar)
                
                NavigationStack {
                    FindDoctorView()
                }
                .tag(AppTab.booking)
                .toolbar(.hidden, for: .tabBar)
                
                NavigationStack {
                    ChatView()
                }
                .tag(AppTab.chat)
                .toolbar(.hidden, for: .tabBar)
                
                NavigationStack {
                    AccountView()
                }
                .tag(AppTab.account)
                .toolbar(.hidden, for: .tabBar)
            }
            
            // 🔴 HIG FIX: Pass the path into the CustomTabBar
            CustomTabBar(selectedTab: $currentTab, homePath: $homeNavigationPath)
                .zIndex(1)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ContentView()
}
