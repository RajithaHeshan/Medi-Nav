


import SwiftUI

struct EmergencyView: View {
    @Environment(\.dismiss) var dismiss
    
   
    @State private var requestAmbulance = false
    @State private var requestWheelchair = false
    @State private var requestTrolley = false
    @State private var requestFirstAid = false
    
   
    @State private var navigateToTracking = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
             
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        Text("Select the type of assistance you need.")
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, -8)
                        Button {
                            print("SOS TRIGGERED")
                        } label: {
                            HStack(spacing: 16) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.25))
                                        .frame(width: 64, height: 64)
                                    Text("SOS")
                                        .font(.title3)
                                        .fontWeight(.heavy)
                                        .foregroundStyle(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Panic / SOS")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Text("Immediate security and medical alert")
                                        .font(.subheadline) // HIG FIX: Increased from caption for readability
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white.opacity(0.9))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            .padding(20)
                            .background(
                                LinearGradient(colors: [Color.red, Color(red: 0.8, green: 0, blue: 0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(color: .red.opacity(0.4), radius: 15, x: 0, y: 8)
                        }
                        
                        // 3. Emergency Options List
                        VStack(spacing: 16) {
                            
                            EmergencyOptionRow(
                                title: "Request Ambulance",
                                subtitle: "External emergency transport",
                                icon: "cross.case.fill",
                                iconColor: .red,
                                isOn: $requestAmbulance,
                                actionText: "Track Ambulance",
                                onActionTap: {
                                    // 🔴 WIRED: Triggers navigation to AmbulanceTrackingView
                                    navigateToTracking = true
                                }
                            )
                            
                            EmergencyOptionRow(
                                title: "Wheelchair",
                                subtitle: "Assistance with mobility",
                                icon: "figure.roll",
                                iconColor: .blue,
                                isOn: $requestWheelchair
                            )
                            
                            EmergencyOptionRow(
                                title: "Patient Trolley",
                                subtitle: "For patients unable to walk",
                                icon: "bed.double.fill",
                                iconColor: .green,
                                isOn: $requestTrolley
                            )
                            
                            EmergencyOptionRow(
                                title: "First Aid",
                                subtitle: "Minor injury treatment",
                                icon: "bandage.fill",
                                iconColor: .teal,
                                isOn: $requestFirstAid
                            )
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
        }
        .navigationBarHidden(true)
       
        .navigationDestination(isPresented: $navigateToTracking) {
            AmbulanceTrackingView()
        }
    }
    
    
    private var headerView: some View {
        HStack(spacing: 16) {
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemBackground))
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.blue)
                        .offset(x: -1.5)
                }
            }
            
            Text("Emergency Help")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
}

// MARK: - Reusable Row Component
struct EmergencyOptionRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color
    @Binding var isOn: Bool
    
    var actionText: String? = nil
    var onActionTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 16) // HIG FIX: Softer corners
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 56, height: 56)
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(subtitle)
                    .font(.subheadline) // HIG FIX: Increased from caption for elder legibility
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                
                // Dynamic Action Button (e.g., Track Ambulance)
                if isOn, let actionText = actionText {
                    Button {
                        onActionTap?()
                    } label: {
                        HStack(spacing: 4) {
                            Text(actionText)
                            Image(systemName: "arrow.right")
                        }
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(iconColor)
                        .padding(.top, 4)
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(iconColor)
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Matched app's 20pt radius
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isOn) // Smoother animation
    }
}

#Preview {
    NavigationStack {
        EmergencyView()
    }
}
