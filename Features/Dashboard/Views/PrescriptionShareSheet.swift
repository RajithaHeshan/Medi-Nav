
import SwiftUI

struct PrescriptionShareSheet: View {
    @Environment(\.dismiss) var dismiss
    
   
    @State private var navigateToNotification = false
    
    var body: some View {
        VStack(spacing: 24) {
            
         
            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(uiColor: .systemBlue).opacity(0.1))
                        .frame(width: 48, height: 56)
                    
                    Image(systemName: "doc.text")
                        .font(.title2)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Prescription_Hashani_R.pdf")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(1)
                    
                    Text("PDF Document • 1.2 MB")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.bold())
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .frame(width: 32, height: 32)
                        .background(Color(uiColor: .systemGray6))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
              
                    ShareAppIcon(title: "AirDrop", icon: "airdrop", iconColor: Color(uiColor: .systemBlue), bgColor: .white) {
                        navigateToNotification = true
                    }
                    
                    
                    ShareAppIcon(title: "WhatsApp", icon: "message.fill", iconColor: .white, bgColor: Color(uiColor: .systemGreen)) {
                        navigateToNotification = true
                    }
                    
                    ShareAppIcon(title: "Gmail", icon: "envelope.fill", iconColor: .white, bgColor: Color(uiColor: .systemRed))
                    
                    ShareAppIcon(title: "Drive", icon: "externaldrive.fill", iconColor: .white, bgColor: Color(uiColor: .systemYellow))
                    
                    ShareAppIcon(title: "Bluetooth", icon: "network", iconColor: .white, bgColor: Color(uiColor: .systemBlue))
                }
                .padding(.horizontal, 20)
            }
            
            // 3. System Actions List
            VStack(spacing: 0) {
                ShareActionRow(title: "Copy", icon: "doc.on.doc")
                Divider().padding(.leading, 16)
                ShareActionRow(title: "Save as PDF", icon: "doc.text")
                Divider().padding(.leading, 16)
                ShareActionRow(title: "Save to Files", icon: "folder")
                Divider().padding(.leading, 16)
                ShareActionRow(title: "Print", icon: "printer")
            }
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 20)
            .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
            
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
     
        .navigationDestination(isPresented: $navigateToNotification) {
            NotificationView()
        }
    }
}



struct ShareAppIcon: View {
    let title: String
    let icon: String
    let iconColor: Color
    let bgColor: Color
    var action: (() -> Void)? = nil
    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(bgColor)
                        .frame(width: 60, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.2), lineWidth: bgColor == .white ? 1 : 0)
                        )
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(iconColor)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
        .buttonStyle(.plain)
    }
}

struct ShareActionRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button {
          
        } label: {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
        }
    }
}

#Preview {
    NavigationStack {
        PrescriptionShareSheet()
    }
}
