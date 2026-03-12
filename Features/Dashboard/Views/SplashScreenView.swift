import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var logoOpacity = 0.0
    @State private var logoScale = 0.8
    @State private var pulseScale = 1.0
    
    var body: some View {
        if isActive {
            // After splash finishes, go to Login
            LoginView()
        } else {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("NewLogin") // Using your specific asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .scaleEffect(logoScale * pulseScale)
                        .opacity(logoOpacity)
                    
                    Text("Medi-Nav")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.blue)
                        .opacity(logoOpacity)
                }
            }
            .onAppear {
                // 1. Fade-in
                withAnimation(.easeIn(duration: 0.8)) {
                    self.logoOpacity = 1.0
                    self.logoScale = 1.0
                }
                
                // 2. Pulse Animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                        self.pulseScale = 1.05
                    }
                }
                
                // 3. Navigate to Login
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
