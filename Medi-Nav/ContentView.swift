

//import SwiftUI
//
//struct ContentView: View {
//    @State private var currentTab: AppTab = .home
//    
//   
//    @State private var homeNavigationPath = NavigationPath()
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            
//            TabView(selection: $currentTab) {
//                
//           
//                NavigationStack(path: $homeNavigationPath) {
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
//         
//            CustomTabBar(selectedTab: $currentTab, homePath: $homeNavigationPath)
//                .zIndex(1)
//        }
//        .ignoresSafeArea(.keyboard, edges: .bottom)
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI

struct ContentView: View {
    @State private var currentTab: AppTab = .home
    @State private var homeNavigationPath = NavigationPath()
    
    
    @State private var homeResetID = UUID()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $currentTab) {
                
                NavigationStack(path: $homeNavigationPath) {
                    HomeView()
                }
                .id(homeResetID) // 🔴 FIX: Attach the ID to the stack
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
            
            CustomTabBar(
                selectedTab: $currentTab,
                homePath: $homeNavigationPath,
                onHomeDoubleTap: {
                    // 🔴 FIX: When the TabBar says to reset, generate a new ID
                    homeResetID = UUID()
                }
            )
            .zIndex(1)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ContentView()
}
