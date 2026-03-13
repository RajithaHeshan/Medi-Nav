

import SwiftUI

struct PaymentConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    let fee: Int
    
    @State private var navigateToBookingHistory = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        Spacer().frame(height: 10)
                        
                       
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.green.opacity(0.15))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "checkmark")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundStyle(.green)
                            }
                            .padding(.bottom, 8)
                            
                            Text("Payment Successful")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color(uiColor: .label))
                            
                            Text("Your appointment has been confirmed. A receipt has been sent to your email.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            
                            VStack(spacing: 4) {
                                Text("AMOUNT PAID")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                
                                Text("$\(fee).00")
                                    .font(.system(size: 40, weight: .heavy))
                                    .foregroundStyle(Color(uiColor: .label))
                            }
                            .padding(.top, 8)
                        }
                        
                       
                        detailsCard
                        
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Transaction ID")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("#TXN-99283410")
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("Payment Method")
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("Visa ending in 4242")
                                    .fontWeight(.bold)
                            }
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        
                        Spacer(minLength: 160)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            bottomFooter
        }
        .navigationBarHidden(true)
        
        // Swapped the placeholder Text for your actual view!
        .navigationDestination(isPresented: $navigateToBookingHistory) {
            BookingHistoryView()
                .navigationBarBackButtonHidden(true) // Keeps the flow clean
        }
    }
    
    // MARK: - Subviews
    
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
            
            Text("Confirmation")
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
    
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack(spacing: 16) {
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("MEDICAL PROFESSIONAL")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    Text(doctor.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(doctor.specialty + " Specialist")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
            }
            
            Divider()
            
            // Date Row
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "calendar")
                    .font(.title3)
                    .foregroundStyle(Color(uiColor: .systemGray3))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("DATE & TIME")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    Text("\(selectedDate.formatted(date: .complete, time: .omitted)) | \(selectedTime)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            
            // Location Row
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.title3)
                    .foregroundStyle(Color(uiColor: .systemGray3))
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("LOCATION")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    Text("Heart & Health Clinic, Suite 402")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(uiColor: .systemGray6), lineWidth: 1)
        )
    }
    
    private var bottomFooter: some View {
        VStack(spacing: 0) {
            Button {
                navigateToBookingHistory = true
            } label: {
                Text("Booking Details")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 90)
        }
        .background(
            Color(uiColor: .systemBackground)
                .ignoresSafeArea(edges: .bottom)
                .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: -5)
        )
    }
}

#Preview {
    NavigationStack {
        PaymentConfirmationView(
            doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "Image (2)", status: "Available", statusColor: .green, isBookable: true),
            selectedDate: Date(),
            selectedTime: "10:30 AM",
            fee: 150
        )
    }
}
