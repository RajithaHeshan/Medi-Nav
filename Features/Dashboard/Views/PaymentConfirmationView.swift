import SwiftUI

struct PaymentConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
   
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    let fee: Int
    
    var body: some View {
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
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                            
                            Text("$\(fee).00")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundStyle(Color(uiColor: .label))
                        }
                        .padding(.top, 8)
                    }
                    
                    // 3. Details Card
                    detailsCard
                    
                    // 4. Transaction Info
                    VStack(spacing: 12) {
                        HStack {
                            Text("Transaction ID")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("#TXN-99283410")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Text("Payment Method")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("Visa ending in 4242")
                                .fontWeight(.medium)
                        }
                    }
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    
                    Spacer(minLength: 30)
                }
                .padding()
            }
            
            // 5. Bottom Button
            Button {
                // In a real app, this might go to "My Bookings"
                // For now, we pop to root or dismiss
                dismiss()
            } label: {
                Text("Booking Details")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1)) // Light blue background from screenshot
                    .background(Color.blue) // Fallback or main color
                    .clipShape(Capsule())
            }
            .padding()
            .padding(.bottom, 10)
        }
        .background(Color(uiColor: .systemBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            Text("Confirmation")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
    }
    
    private var detailsCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Doctor Row
            HStack(spacing: 16) {
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("MEDICAL PROFESSIONAL")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    Text(doctor.name)
                        .font(.headline)
                    
                    Text(doctor.specialty + " Specialist")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }
            
            Divider()
            
            // Date Row
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "calendar")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("DATE & TIME")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    // Formatting the date nicely
                    Text("\(selectedDate.formatted(date: .complete, time: .omitted)) | \(selectedTime)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            
            // Location Row (Hardcoded based on design since model lacks location)
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("LOCATION")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    
                    Text("Heart & Health Clinic, Suite 402")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        // The Border Stroke
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(uiColor: .systemGray6), lineWidth: 1)
        )
        // The Shadow
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    PaymentConfirmationView(
        doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "doctor1", status: "Available", statusColor: .green, isBookable: true),
        selectedDate: Date(),
        selectedTime: "10:30 AM",
        fee: 150
    )
}
