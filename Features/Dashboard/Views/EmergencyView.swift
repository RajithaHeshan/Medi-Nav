
import SwiftUI

struct EmergencyView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var requestAmbulance = false
    @State private var requestWheelchair = false
    @State private var requestTrolley = false
    @State private var requestFirstAid = false
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
               
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(Color(uiColor: .label))
                    }
                    
                    Text("Emergency Help")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                }
                .padding(.top, 10)
                
              
                Text("Select the type of assistance you need.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        
                        Button {
                            print("SOS TRIGGERED")
                        } label: {
                            HStack(spacing: 16) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 60, height: 60)
                                    Text("SOS")
                                        .font(.headline)
                                        .bold()
                                        .foregroundStyle(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Panic / SOS")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text("Immediate security and medical alert")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.9))
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            .padding(20)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        
                       
                        VStack(spacing: 16) {
                            
                           
                            EmergencyOptionRow(
                                title: "Request Ambulance",
                                subtitle: "External emergency transport",
                                icon: "cross.case.fill",
                                iconColor: .red,
                                isOn: $requestAmbulance,
                                
                                actionText: "Track Ambulance",
                                onActionTap: {
                                    print("Navigate to Ambulance Tracking Map")
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
                    }
                    .padding(.bottom, 40)
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Reusable Option Row (Updated)
struct EmergencyOptionRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color
    @Binding var isOn: Bool
    
    // NEW Optional Parameters for "Track" Action
    var actionText: String? = nil
    var onActionTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(iconColor)
            }
            
            // Text Column
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                // 🔴 NEW: Conditional Action Text (Track Ambulance)
                if isOn, let actionText = actionText {
                    Button {
                        onActionTap?()
                    } label: {
                        HStack(spacing: 4) {
                            Text(actionText)
                            Image(systemName: "arrow.right")
                        }
                        .font(.caption) // Same size as Home Page
                        .bold()
                        .foregroundStyle(iconColor) // Matches the icon color (Red)
                        .padding(.top, 2)
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(iconColor)
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        // Animates the text appearing/disappearing
        .animation(.spring(), value: isOn)
    }
}

#Preview {
    EmergencyView()
}
