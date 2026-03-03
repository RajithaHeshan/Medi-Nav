import SwiftUI

struct AppointmentHistory: Identifiable {
    let id = UUID()
    let doctor: Doctor
    let dateString: String
    let status: String
}

struct BookingHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedTab = "Completed"
    
   
    @State private var doctorToRebook: Doctor?
    
    
    private let appointments = [
        AppointmentHistory(
            doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "General Practitioner", rating: 4.9, reviewCount: 120, fee: 150, image: "doctor1", status: "Available", statusColor: .green, isBookable: true),
            dateString: "Oct 12, 2023 - 10:00",
            status: "Completed"
        ),
        AppointmentHistory(
            doctor: Doctor(name: "Dr. Michael Chen", specialty: "Cardiologist", rating: 4.8, reviewCount: 90, fee: 180, image: "doctor1", status: "Available", statusColor: .green, isBookable: true),
            dateString: "Sep 28, 2023 - 02:30 PM",
            status: "Completed"
        ),
        AppointmentHistory(
            doctor: Doctor(name: "Dr. Elena Rodriguez", specialty: "Pediatrician", rating: 4.7, reviewCount: 65, fee: 120, image: "Image (2)", status: "Available", statusColor: .green, isBookable: true),
            dateString: "Aug 15, 2023 - 09:15",
            status: "Completed"
        )
    ]
    
    var filteredAppointments: [AppointmentHistory] {
        return appointments.filter { $0.status == selectedTab }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                
                headerView
                
              
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("Search by name or specialty...", text: $searchText)
                }
                .padding(12)
                .background(Color(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.bottom, 16)
                
              
                HStack(spacing: 0) {
                    tabButton(title: "Upcoming")
                    tabButton(title: "Completed")
                }
                .padding(4)
                .background(Color(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.bottom, 20)
                
                // 4. List
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(filteredAppointments) { appointment in
                            BookingHistoryCard(appointment: appointment) {
                                // Rebook Action
                                doctorToRebook = appointment.doctor
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            
            // 5. Rebook Navigation
            .navigationDestination(item: $doctorToRebook) { doctor in
                DoctorBookingView(doctor: doctor)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            Text("Booking History")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
    }
    
    // Custom Tab Button
    private func tabButton(title: String) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = title
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedTab == title ? Color.white : Color.clear)
                .foregroundStyle(selectedTab == title ? Color.black : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: selectedTab == title ? Color.black.opacity(0.1) : Color.clear, radius: 2, x: 0, y: 1)
        }
    }
}

// MARK: - Card Component
struct BookingHistoryCard: View {
    let appointment: AppointmentHistory
    var onRebook: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Top: Doctor Info
            HStack(spacing: 16) {
                // Avatar
                Image(appointment.doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.doctor.name)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(appointment.doctor.specialty)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.gray.opacity(0.5))
            }
            .padding(16)
            
          
            Divider()
                .padding(.horizontal, 16)
            
         
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of visit")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(appointment.dateString)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                Spacer()
                
                // Rebook Button
                Button(action: onRebook) {
                    Text("Rebook")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.green.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    BookingHistoryView()
}
