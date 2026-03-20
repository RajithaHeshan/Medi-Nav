

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
   
    @State private var logoOpacity = 0.0
    @State private var logoScale = 0.6
    @State private var pulseScale = 1.0
    @State private var logoOffset: CGFloat = 30
    
    @State private var loadingProgress: CGFloat = 0.0
    
    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    VStack(spacing: 24) {
                        Image("NewLogin")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
                            .shadow(color: Color.black.opacity(0.12), radius: 20, x: 0, y: 10)
                            .scaleEffect(logoScale * pulseScale)
                            .offset(y: logoOffset)
                            .opacity(logoOpacity)
                        
                        Text("Medi-Nav")
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .foregroundStyle(Color.blue)
                            .opacity(logoOpacity)
                            .offset(y: logoOffset)
                    }
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.15))
                            .frame(width: 220, height: 6)
                        
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 220 * loadingProgress, height: 6)
                    }
                    .opacity(logoOpacity)
                }
            }
            .onAppear {
                
         
                withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0)) {
                    self.logoOpacity = 1.0
                    self.logoScale = 1.0
                    self.logoOffset = 0
                }
                
              
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                        self.pulseScale = 1.02 
                    }
                }
                
              
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.loadingProgress = 1.0
                    }
                }
                
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
