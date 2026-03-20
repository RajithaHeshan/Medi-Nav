
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
    
  
    @State private var isListening = false
    
    let tabs = ["Upcoming", "Completed"]
    
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
        var filtered = appointments.filter { $0.status == selectedTab }
        
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.doctor.name.localizedCaseInsensitiveContains(searchText) ||
                $0.doctor.specialty.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filtered
    }
    
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
                                .offset(x: -1.5)
                        }
                    }
                    
                    Text("Booking History")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 16)
                
           
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(uiColor: .systemGray2))
                        .font(.body.weight(.medium))
                    
                    TextField("Search by name or specialty...", text: $searchText)
                    
                    Spacer()
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            withAnimation { searchText = "" }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color(uiColor: .systemGray3))
                                .font(.body.weight(.medium))
                        }
                    } else {
                        // 🔴 MICROPHONE BUTTON ACTION
                        Button(action: {
                            withAnimation { isListening = true }
                        }) {
                            Image(systemName: "mic.fill")
                                .foregroundStyle(Color.blue)
                                .font(.body.weight(.medium))
                        }
                    }
                }
                .padding(10)
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
           
                Picker("Status", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
              
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(filteredAppointments) { appointment in
                            BookingHistoryCard(appointment: appointment) {
                                doctorToRebook = appointment.doctor
                            }
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
            
           
            if isListening {
                voiceAnimationOverlay
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(item: $doctorToRebook) { doctor in
            DoctorBookingView(doctor: doctor)
        }
    }
    
    // MARK: - Voice Animation View
    private var voiceAnimationOverlay: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Listening...")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 4) {
                    ForEach(0..<8) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: 4, height: isListening ? CGFloat.random(in: 10...60) : 10)
                            .animation(.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: isListening)
                    }
                }
                
                Button {
                    isListening = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }
            .padding(40)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .transition(.opacity)
    }
}

// Keep your original BookingHistoryCard and SearchTag exactly as they were
struct BookingHistoryCard: View {
    let appointment: AppointmentHistory
    var onRebook: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemGray6))
                        .frame(width: 56, height: 56)
                    
                    Image(appointment.doctor.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.doctor.name)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(appointment.doctor.specialty)
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(Color(uiColor: .systemGray3))
            }
            .padding(16)
            
            Divider()
                .padding(.horizontal, 16)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Date of visit")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    
                    Text(appointment.dateString)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                Spacer()
                
                Button(action: onRebook) {
                    Text("Rebook")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            }
            .padding(16)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}
#Preview {

    NavigationStack {
        BookingHistoryView()
    }
}
