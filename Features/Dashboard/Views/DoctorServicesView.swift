import SwiftUI

struct DoctorServicesView: View {
    @Environment(\.dismiss) var dismiss
    
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Custom Header
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    // 2. Upcoming Appointment Card
                    upcomingAppointmentCard
                    
                    // 3. Browse by Specialty Section
                    specialtySection
                    
                    // 4. Main Action Grid (Now with Native SF Symbols)
                    actionGridSection
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        // 🔴 THE FIX: HIG standard 16pt spacing
        HStack(spacing: 16) {
            Button {
                dismiss()
            } label: {
                // 🔴 THE FIX: HIG standard chevron instead of arrow
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
            Text("Doctor Services")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var upcomingAppointmentCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Upcoming Appointment")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                
                Spacer()
                
                Text("10:30 AM")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(uiColor: .systemBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
            
            Text("Friday, Oct 25")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemBlue).opacity(0.1))
                        .frame(width: 40, height: 40)
                    Image(systemName: "cross.case.fill").foregroundStyle(Color(uiColor: .systemBlue))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dr. Sarah Wilson")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text("Cardiologist - Room 12")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            HStack(spacing: 12) {
                Button { } label: {
                    Text("Reschedule")
                        .font(.subheadline).fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                }
                
                Button { } label: {
                    Text("Cancel")
                        .font(.subheadline).fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .systemRed))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .systemRed).opacity(0.05))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color(uiColor: .systemRed).opacity(0.3), lineWidth: 1))
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var specialtySection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Browse by Specialty")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Button("See All") { }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
            HStack(spacing: 0) {
                SpecialtyIcon(title: "General", icon: "stethoscope", color: Color(uiColor: .systemBlue))
                Spacer()
                SpecialtyIcon(title: "Dental", icon: "cross.case.fill", color: Color(uiColor: .systemGreen))
                Spacer()
                SpecialtyIcon(title: "Eye", icon: "eye.fill", color: Color(uiColor: .systemPurple))
                Spacer()
                SpecialtyIcon(title: "Heart", icon: "heart.fill", color: Color(uiColor: .systemRed))
            }
            .padding(.horizontal, 8)
        }
    }
    
    // 🔴 UPDATED: Using the new ServiceActionCard with Native SF Symbols
    private var actionGridSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            
            ServiceActionCard(
                title: "Doctors Booking",
                iconName: "calendar.badge.plus",
                iconColor: Color(uiColor: .systemBlue)
            )
            
            ServiceActionCard(
                title: "Booking History",
                iconName: "list.clipboard.fill",
                iconColor: Color(uiColor: .systemTeal)
            )
            
            ServiceActionCard(
                title: "Doctor Consulting",
                iconName: "video.fill",
                iconColor: Color(uiColor: .systemIndigo)
            )
            
            ServiceActionCard(
                title: "Consulting History",
                iconName: "clock.fill",
                iconColor: Color(uiColor: .systemPurple)
            )
        }
    }
}

// MARK: - Reusable Components

struct SpecialtyIcon: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
            }
            
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}

// 🔴 THE FIX: Redesigned Card to use native SF Symbols instead of missing images
struct ServiceActionCard: View {
    let title: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        Button {
            // Action for card tap
        } label: {
            VStack(spacing: 16) {
                
                // Native Symbol Container
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(iconColor)
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    DoctorServicesView()
}
