import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            
            Section("New") {
                NotificationRow(
                    icon: "calendar.badge.clock",
                    color: .blue,
                    title: "Appointment Reminder",
                    message: "Your cardiology consultation with Dr. Sarah Wilson is tomorrow at 10:30 AM.",
                    time: "10m ago",
                    isUnread: true
                )
                
                NotificationRow(
                    icon: "testtube.2",
                    color: .purple,
                    title: "Lab Results Ready",
                    message: "Your recent lipid profile and blood test results have been uploaded to your portal.",
                    time: "2h ago",
                    isUnread: true
                )
            }
            
           
            Section("Earlier") {
                NotificationRow(
                    icon: "pills.fill",
                    color: .green,
                    title: "Prescription Ready",
                    message: "Your Amoxicillin prescription is ready for pickup at the Main Pharmacy.",
                    time: "Yesterday",
                    isUnread: false
                )
                
                NotificationRow(
                    icon: "checkmark.seal.fill",
                    color: .orange,
                    title: "Check-in Successful",
                    message: "You successfully checked in for your appointment.",
                    time: "Oct 20",
                    isUnread: false
                )
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Notifications")
    
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Mark All Read") {
                    // Logic to clear notifications
                }
                .font(.subheadline)
            }
        }
    }
}


struct NotificationRow: View {
    let icon: String
    let color: Color
    let title: String
    let message: String
    let time: String
    let isUnread: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            Circle()
                .fill(isUnread ? Color.blue : Color.clear)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundStyle(color)
                    .font(.title3)
            }
            
           
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(isUnread ? .bold : .semibold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Spacer()
                    
                    Text(time)
                        .font(.caption2)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Text(message)
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
     
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
               
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    NavigationStack {
        NotificationView()
    }
}

