import SwiftUI

// 1. Define the Tab Enum globally so any file can see it
enum AppTab {
    case home
    case chat
    case account
}

// 2. The Main Tab Bar Container
struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        VStack(spacing: 0) {
            Divider() // The thin grey separator
                .background(Color(uiColor: .separator))
            
            HStack(spacing: 0) {
                // HOME
                TabBarButton(
                    icon: "house.fill",
                    text: "Home",
                    tab: .home,
                    selectedTab: $selectedTab
                )
                
                // CHAT
                TabBarButton(
                    icon: "bubble.left.and.bubble.right.fill",
                    text: "Chat",
                    tab: .chat,
                    selectedTab: $selectedTab
                )
                .overlay(notificationBadge)
                
                // ACCOUNT
                TabBarButton(
                    icon: "person.circle.fill",
                    text: "Account",
                    tab: .account,
                    selectedTab: $selectedTab
                )
            }
            .frame(height: 60) // Standard iOS Tab Height
            .background(Color(uiColor: .systemBackground)) // Solid White Background
        }
    }
    
    // Sub-view for the badge (Clean Code: Keep the body simple)
    private var notificationBadge: some View {
        Text("2")
            .font(.caption2)
            .bold()
            .foregroundStyle(.white)
            .padding(5)
            .background(Color.red)
            .clipShape(Circle())
            .offset(x: 10, y: -10)
    }
}

// 3. The Individual Button Component
struct TabBarButton: View {
    let icon: String
    let text: String
    let tab: AppTab
    @Binding var selectedTab: AppTab
    
    // Semantic Colors (Computed Property)
    private var iconColor: Color {
        selectedTab == tab ? .blue : .gray
    }
    
    var body: some View {
        Button {
            // Add Haptic Feedback for a "Physical" feel
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(iconColor)
                    .symbolEffect(.bounce, value: selectedTab == tab) // iOS 17 Animation!
                
                Text(text)
                    .font(.caption)
                    .foregroundStyle(iconColor)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle()) // Makes the whole area clickable
        }
    }
}

// MARK: - Preview (Isolated Component Test)

#Preview {
    ZStack(alignment: .bottom) {
        
        Color.gray.ignoresSafeArea()
        
        CustomTabBar(selectedTab: .constant(.home))
    }
}
