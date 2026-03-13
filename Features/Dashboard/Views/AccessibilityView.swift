import SwiftUI

struct AccessibilityView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
           
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
               
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                    
                        VStack(alignment: .leading, spacing: 8) {
                           
                            AccessibilitySectionHeader(title: "Vision")
                            
                            VStack(spacing: 0) {
                                AccessibilityRow(icon: "person.wave.2.fill", iconBgColor: .purple, title: "VoiceOver", showDivider: true)
                                AccessibilityRow(icon: "plus.magnifyingglass", iconBgColor: .blue, title: "Zoom", showDivider: true)
                                AccessibilityRow(icon: "textformat.size", iconBgColor: .blue, title: "Display & Text Size", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                           
                            AccessibilitySectionHeader(title: "Physical and Motor")
                            
                            VStack(spacing: 0) {
                                AccessibilityRow(icon: "hand.tap.fill", iconBgColor: .green, title: "Touch", showDivider: true)
                                AccessibilityRow(icon: "faceid", iconBgColor: .blue, title: "Face ID & Attention", showDivider: true)
                                AccessibilityRow(icon: "switch.2", iconBgColor: .green, title: "Switch Control", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                     
                        VStack(alignment: .leading, spacing: 8) {
                         
                            AccessibilitySectionHeader(title: "Hearing")
                            
                            VStack(spacing: 0) {
                                AccessibilityRow(icon: "ear.fill", iconBgColor: .orange, title: "Hearing Devices", showDivider: true)
                                AccessibilityRow(icon: "waveform", iconBgColor: .red, title: "Sound Recognition", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                       
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
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
            
            Spacer()
            
            Text("Accessibility")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
}


struct AccessibilitySectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundStyle(Color(uiColor: .secondaryLabel))
            .padding(.leading, 16)
            .padding(.top, 8)
    }
}

struct AccessibilityRow: View {
    let icon: String
    let iconBgColor: Color
    let title: String
    var subtitle: String? = nil
    var showDivider: Bool
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    
                  
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(iconBgColor)
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    
                 
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(uiColor: .label))
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.caption)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if showDivider {
                    Divider()
                        .padding(.leading, 64)                 }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
