
import SwiftUI

struct BookingConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    let patientType: String
    
    @State private var showPayment = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        doctorSummaryCard
                        
                        appointmentDetailsCard
                        
                        paymentSummaryCard
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    .padding(.bottom, 140)
                }
            }
            
           
            bottomFooter
        }
        .navigationBarHidden(true)
        
        .navigationDestination(isPresented: $showPayment) {
            PaymentView(
                doctor: doctor,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                flowType: .doctorBooking
            )
        }
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
            
            Text("Booking Summary")
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
    
    private var doctorSummaryCard: some View {
        HStack(spacing: 16) {
            Image(doctor.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(doctor.specialty)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(Color.blue)
                    Text("Nawaloka Hospital, Colombo")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                .padding(.top, 2)
            }
            Spacer()
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 4)
    }
    
    private var appointmentDetailsCard: some View {
        VStack(spacing: 0) {
            detailRow(icon: "calendar", title: "Date", value: selectedDate.formatted(.dateTime.day().month(.wide).year()))
            Divider().padding(.leading, 48)
            detailRow(icon: "clock.fill", title: "Time", value: selectedTime)
            Divider().padding(.leading, 48)
            detailRow(icon: "person.fill", title: "Patient Type", value: patientType)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 4)
    }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.blue)
            }
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
    
    private var paymentSummaryCard: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Consultation Fee")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Text("$\(doctor.fee).00")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text("Booking Charge")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Text("$5.00")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            Divider()
            
            HStack {
                Text("Total Payable")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                Spacer()
                Text("$\(doctor.fee + 5).00")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 4)
    }
    
   
    private var bottomFooter: some View {
        VStack {
            Button {
                showPayment = true
            } label: {
                Text("Proceed to Payment")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 24)
        .background(
            .regularMaterial
        )
    }
}

#Preview {
    NavigationStack {
        BookingConfirmationView(
            doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "Image (2)", status: "Available Today", statusColor: .green, isBookable: true),
            selectedDate: Date(),
            selectedTime: "10:30 AM",
            patientType: "Adult"
        )
    }
}
