
import SwiftUI

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    
    
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    
   
    @State private var selectedPaymentMethod: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("APPOINTMENT SUMMARY")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .padding(.leading, 4)
                        
                       
                        appointmentDetailsCard
                    }
                    
                   
                    VStack(alignment: .leading, spacing: 16) {
                        Text("PAYMENT METHOD")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .padding(.leading, 4)
                        
                       
                        Button {
                            print("Apple Pay Tapped")
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "apple.logo")
                                    .font(.title2)
                                Text("Pay with Apple Pay")
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        
                        // Card
                        PaymentOptionRow(
                            icon: "creditcard.fill",
                            iconColor: .blue,
                            title: "Credit/Debit Card",
                            subtitle: "Visa, Mastercard, AMEX",
                            isSelected: selectedPaymentMethod == 0
                        ) {
                            selectedPaymentMethod = 0
                        }
                        
                        // Insurance
                        PaymentOptionRow(
                            icon: "shield.fill",
                            iconColor: .gray,
                            title: "Health Insurance",
                            subtitle: "Use provider coverage",
                            isSelected: selectedPaymentMethod == 1
                        ) {
                            selectedPaymentMethod = 1
                        }
                    }
                    
                    
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        
                        Text("Your payment information is encrypted and securely processed by our medical gateway.")
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.2), lineWidth: 1))
                    
                    Spacer(minLength: 20)
                }
                .padding(20)
            }
            
            
            bottomFooter
        }
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .navigationBarHidden(true)
    }
    
   
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            Text("Payment").font(.headline).bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding().background(Color(uiColor: .systemBackground))
    }
    
    
    private var appointmentDetailsCard: some View {
        VStack(spacing: 0) {
            // Top Row: Doctor Info
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(doctor.name)
                        .font(.headline)
                    Text(doctor.specialty)
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
                Spacer()
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(16)
            
            Divider().padding(.horizontal, 16)
            
      
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar").foregroundStyle(.blue)
                    Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "clock").foregroundStyle(.blue)
                    Text(selectedTime)
                        .font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .padding(16)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
    
    private var bottomFooter: some View {
        VStack(spacing: 16) {
            Divider()
            HStack {
                Text("Total Amount").foregroundStyle(.secondary)
                Spacer()
                Text("$\(doctor.fee).00").font(.title2).bold()
            }
            .padding(.horizontal)
            
            Button { print("Processing Payment...") } label: {
                Text("Pay Now").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(Capsule())
            }
            .padding(.horizontal).padding(.bottom, 10)
        }
        .padding(.top, 16)
        .background(Color(uiColor: .systemBackground).ignoresSafeArea(edges: .bottom))
        .shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
    }
}


struct PaymentOptionRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemGray6)).frame(width: 48, height: 48)
                    Image(systemName: icon).font(.title3).foregroundStyle(iconColor)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label))
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2).foregroundStyle(isSelected ? .blue : .gray.opacity(0.3))
            }
            .padding(16)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PaymentView(
        doctor: Doctor(name: "Dr. Michael Chen", specialty: "Pediatrician", rating: 4.8, reviewCount: 90, fee: 100, image: "doctor1", status: "Available", statusColor: .green, isBookable: true),
        selectedDate: Date(),
        selectedTime: "10:30 AM"
    )
}
