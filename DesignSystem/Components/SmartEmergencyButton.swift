
import SwiftUI

struct SmartEmergencyButton: View {
    // State to track if the button is "Popped Up" or "Cornered"
    @State private var isExpanded: Bool = false
    
    // Action to perform when actually clicked
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            // 1. The Icon (Always Visible)
            Image(systemName: "phone.fill")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
            
            // 2. The Text (Hidden when in Corner)
            if isExpanded {
                Text("Emergency Help")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .fixedSize()
                    .padding(.trailing, 20)
                    // Text Transition Effect
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .background(Color.red)
        .clipShape(Capsule())
        // HIG Shadow
        .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
        
        // 3. THE GESTURE LOGIC (Swipe to Expand/Collapse)
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width < 0 {
                        // Swipe LEFT -> Expand (Popup)
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded = true
                        }
                    } else if value.translation.width > 0 {
                        // Swipe RIGHT -> Collapse (Corner)
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            isExpanded = false
                        }
                    }
                }
        )
        // 4. Tap Logic: If collapsed, tap expands it. If expanded, tap calls.
        .onTapGesture {
            if isExpanded {
                action()
            } else {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    isExpanded = true
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        SmartEmergencyButton {
            print("Calling 911...")
        }
    }
}
