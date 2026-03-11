import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
            
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
          
                        profileHeaderCard
                        
                   
                        VStack(alignment: .leading, spacing: 8) {
                        
                            AccountSectionHeader(title: "Medical & Records")
                            
                            VStack(spacing: 0) {
                                AccountRow(icon: "heart.fill", iconColor: .blue, title: "My Medical History", showDivider: true)
                                AccountRow(icon: "creditcard.fill", iconColor: .blue, title: "Insurance & Billing", showDivider: true)
                                AccountRow(icon: "mappin.and.ellipse", iconColor: .blue, title: "Saved Pharmacies", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                 
                        VStack(alignment: .leading, spacing: 8) {
                          
                            AccountSectionHeader(title: "Preferences")
                            
                            VStack(spacing: 0) {
                                AccountRow(icon: "gearshape.fill", iconColor: .gray, title: "Settings", showDivider: true)
                                AccountRow(icon: "accessibility.fill", iconColor: .gray, title: "Accessibility", subtitle: "VoiceOver, High Contrast, Text Size", showDivider: true)
                                AccountRow(icon: "bell.fill", iconColor: .gray, title: "Notifications", showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                   
                        Button {
                           
                        } label: {
                            Text("Log Out")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color.red.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                        .padding(.top, 8)
                        
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
            
            Text("Account")
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
    
    private var profileHeaderCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 72, height: 72)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundStyle(Color.orange.opacity(0.6))
                    .frame(width: 72, height: 72)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Dilsha Mallawaarachchie")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text("ID: #98420-A")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                
                Button {
                    // Edit action
                } label: {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                        .padding(.top, 2)
                }
            }
            Spacer()
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}


struct AccountSectionHeader: View {
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

struct AccountRow: View {
    let icon: String
    let iconColor: Color
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
                        Circle()
                            .fill(iconColor.opacity(0.1))
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: icon)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(iconColor)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(uiColor: .label))
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.caption2)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.bold))
                        .foregroundStyle(Color(uiColor: .systemGray4))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if showDivider {
                    Divider()
                        .padding(.leading, 72)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        AccountView()
    }
}
