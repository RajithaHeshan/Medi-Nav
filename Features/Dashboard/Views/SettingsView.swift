import SwiftUI

struct SettingsView: View {
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
                            SettingsSectionHeader(title: "Account")
                            
                            VStack(spacing: 0) {
                                SettingsRow(icon: "person.fill", iconBgColor: .blue, title: "Personal Information", showDivider: true)
                                SettingsRow(icon: "lock.fill", iconBgColor: .green, title: "Security & Password", showDivider: true)
                              
                                SettingsRow(icon: "hand.raised.fill", iconBgColor: .blue, title: "Privacy Settings", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                     
                        VStack(alignment: .leading, spacing: 8) {
                            SettingsSectionHeader(title: "Preferences")
                            
                            VStack(spacing: 0) {
                                SettingsRow(icon: "character.book.closed.fill", iconBgColor: .indigo, title: "Language", showDivider: true)
                               
                                SettingsRow(icon: "ruler.fill", iconBgColor: .cyan, title: "Units of Measure", subtitle: "Metric (°C, kg, cm)", showDivider: true)
                                SettingsRow(icon: "arrow.triangle.2.circlepath", iconBgColor: .purple, title: "Data Sync", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 8) {
                            SettingsSectionHeader(title: "Support")
                            
                            VStack(spacing: 0) {
                                SettingsRow(icon: "questionmark.circle.fill", iconBgColor: .blue, title: "Help Center", showDivider: true)
                                SettingsRow(icon: "envelope.fill", iconBgColor: .teal, title: "Contact Us", showDivider: true)
                                SettingsRow(icon: "doc.text.fill", iconBgColor: .gray, title: "Terms & Conditions", showDivider: false)
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
            
         
            Text("Settings")
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



struct SettingsSectionHeader: View {
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

struct SettingsRow: View {
    let icon: String
    let iconBgColor: Color
    let title: String
    var subtitle: String? = nil
    var showDivider: Bool
    
    var body: some View {
        Button(action: {
            // Row tap action
        }) {
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
                    
                    // Texts
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
                        .padding(.leading, 64)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

