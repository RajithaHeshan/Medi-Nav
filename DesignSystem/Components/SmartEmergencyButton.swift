import SwiftUI

struct SmartEmergencyButton: View {
    
    @State private var isExpanded: Bool = false
    
    
    var action: () -> Void
    
    var body: some View {
       
        HStack(spacing: 0) {
          
            Image(systemName: "phone.fill")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
            
            
            if isExpanded {
                Text("Emergency Help")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    // Prevents text from wrapping/jumping during animation
                    .fixedSize()
                    .padding(.trailing, 20)
                    // Smooth slide-in transition
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .background(Color.red)
        .clipShape(Capsule())
        // Standard iOS Shadow for depth
        .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
        
        // MARK: - Gestures
        
        // 3. Swipe Logic
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width < 0 {
                        // User swiped LEFT <- (Pulling it out)
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded = true
                        }
                    } else if value.translation.width > 0 {
                        // User swiped RIGHT -> (Pushing it back)
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded = false
                        }
                    }
                }
        )
        
        // 4. Tap Logic
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                if isExpanded {
                    // If already open, perform the action (Navigate/Call)
                    action()
                } else {
                    // If closed, just open it first (Better UX)
                    isExpanded = true
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        
        // Test the button in the bottom right corner
        VStack {
            Spacer()
            HStack {
                Spacer()
                SmartEmergencyButton {
                    print("Emergency Action Triggered!")
                }
                .padding()
            }
        }
    }
}
