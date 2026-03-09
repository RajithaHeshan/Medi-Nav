
import SwiftUI

struct DoctorServicesView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Navigation States
    @State private var navigateToFindDoctor = false
    @State private var navigateToBookingHistory = false
    @State private var navigateToDoctorConsultation = false
    @State private var navigateToConsultationHistory = false
    @State private var navigateToReschedule = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
          
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
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
                                .offset(x: -1.5) // 🔴 FIX 2: Visually centers the Apple SF Symbol!
                        }
                    }
                    
                    Text("Doctor Services")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)
                
                // Main Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        upcomingAppointmentCard
                        browseBySpecialtySection
                        actionGrid
                        
                        Spacer(minLength: 120) // Keeps content above Tab Bar
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarHidden(true) // Completely hides the buggy native bar
        
        // MARK: - Navigation Destinations
        .navigationDestination(isPresented: $navigateToFindDoctor) {
            FindDoctorView()
        }
        .navigationDestination(isPresented: $navigateToBookingHistory) {
            BookingHistoryView()
        }
        .navigationDestination(isPresented: $navigateToDoctorConsultation) {
            DoctorConsultationView()
        }
        .navigationDestination(isPresented: $navigateToConsultationHistory) {
            DoctorConsultationHistoryView()
        }
        .navigationDestination(isPresented: $navigateToReschedule) {
            DoctorBookingView(
                doctor: Doctor(
                    name: "Dr. Sarah Wilson",
                    specialty: "Cardiologist",
                    rating: 4.9,
                    reviewCount: 120,
                    fee: 150,
                    image: "Ellipse 522",
                    status: "Available Today",
                    statusColor: .green,
                    isBookable: true
                )
            )
        }
    }
    
    // MARK: - View Components
    
    private var upcomingAppointmentCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Friday, Oct 25")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 48, height: 48)
                    Image(systemName: "cross.case.fill")
                        .foregroundStyle(Color.blue)
                        .font(.title3)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dr. Sarah Wilson")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text("Cardiologist - Room 12")
                        .font(.caption)
                        .foregroundStyle(Color.primary.opacity(0.75))
                }
            }
            
            HStack(spacing: 12) {
                Button {
                    navigateToReschedule = true
                } label: {
                    Text("Reschedule")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                }
                
                Button {
                    // Cancel action logic
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red.opacity(0.05))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.red.opacity(0.2), lineWidth: 1))
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var browseBySpecialtySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Browse by Specialty")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Button("See All") {
                    navigateToFindDoctor = true
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.blue)
            }
            
            HStack(spacing: 0) {
                specialtyButton(icon: "stethoscope", title: "General", iconColor: .blue)
                Spacer()
                specialtyButton(icon: "cross.case.fill", title: "Dental", iconColor: .green)
                Spacer()
                specialtyButton(icon: "eye.fill", title: "Eye", iconColor: .purple)
                Spacer()
                specialtyButton(icon: "heart.fill", title: "Heart", iconColor: .red)
            }
        }
    }
    
    private var actionGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            Button { navigateToFindDoctor = true } label: {
                ServiceGridCard(icon: "calendar.badge.plus", iconColor: .blue, title: "Doctors Booking")
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToBookingHistory = true } label: {
                ServiceGridCard(icon: "list.clipboard.fill", iconColor: .cyan, title: "Booking History")
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToDoctorConsultation = true } label: {
                ServiceGridCard(icon: "video.fill", iconColor: .indigo, title: "Doctor Consulting")
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToConsultationHistory = true } label: {
                ServiceGridCard(icon: "clock.fill", iconColor: .purple, title: "Consulting History")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    // MARK: - Reusable Subcomponents
    
    private func specialtyButton(icon: String, title: String, iconColor: Color) -> some View {
        Button {
            navigateToFindDoctor = true
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 60, height: 60)
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(iconColor)
                }
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
    }
}

// Extracted structurally so it can be reused easily
struct ServiceGridCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 56, height: 56)
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(iconColor)
            }
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 8)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    NavigationStack {
        DoctorServicesView()
    }
}
