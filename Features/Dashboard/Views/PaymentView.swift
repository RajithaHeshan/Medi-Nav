
import SwiftUI

enum PaymentFlowType {
    case pharmacy
    case labReport
    case doctorBooking
}

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    
    let flowType: PaymentFlowType
    
    @State private var selectedPaymentMethod: Int = 0
    
   
    @State private var navigateToPharmacy = false
    @State private var navigateToLabReports = false
    @State private var navigateToBookingConfirmation = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("APPOINTMENT SUMMARY")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .padding(.leading, 4)
                            
                            appointmentDetailsCard
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("PAYMENT METHOD")
                                .font(.caption)
                                .fontWeight(.bold)
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
                            
                            PaymentOptionRow(
                                icon: "creditcard.fill", iconColor: .blue, title: "Credit/Debit Card", subtitle: "Visa, Mastercard, AMEX", isSelected: selectedPaymentMethod == 0
                            ) { withAnimation(.spring()) { selectedPaymentMethod = 0 } }
                            
                            PaymentOptionRow(
                                icon: "shield.fill", iconColor: .gray, title: "Health Insurance", subtitle: "Use provider coverage", isSelected: selectedPaymentMethod == 1
                            ) { withAnimation(.spring()) { selectedPaymentMethod = 1 } }
                        }
                        
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue)
                            Text("Your payment information is encrypted and securely processed by our medical gateway.")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.blue)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 2)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.2), lineWidth: 1))
                        
                       
                        Spacer(minLength: 240)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            
       
            bottomFooter
        }
        .navigationBarHidden(true)
        
      
        .navigationDestination(isPresented: $navigateToPharmacy) {
            PharmacyView()
        }
        .navigationDestination(isPresented: $navigateToLabReports) {
            LabReportsView()
        }
        .navigationDestination(isPresented: $navigateToBookingConfirmation) {
            
            PaymentConfirmationView(
                doctor: doctor,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                fee: doctor.fee
            )
            .navigationBarBackButtonHidden(true)
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
            
            Text("Payment")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var appointmentDetailsCard: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(doctor.name).font(.headline).fontWeight(.bold)
                    Text(doctor.specialty).font(.subheadline).foregroundStyle(.blue)
                }
                Spacer()
                Image(doctor.image).resizable().scaledToFill().frame(width: 56, height: 56).clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(20)
            
            Divider().padding(.horizontal, 20)
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar").foregroundStyle(.blue)
                    Text(selectedDate.formatted(date: .abbreviated, time: .omitted)).font(.subheadline).fontWeight(.medium).foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "clock").foregroundStyle(.blue)
                    Text(selectedTime).font(.subheadline).fontWeight(.medium).foregroundStyle(.secondary)
                }
            }
            .padding(20)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var bottomFooter: some View {
        VStack(spacing: 16) {
            HStack(alignment: .bottom) {
                Text("Total Amount").font(.subheadline).foregroundStyle(.secondary)
                Spacer()
                Text("$\(doctor.fee).00").font(.title2).fontWeight(.heavy)
            }
            
            Button {
                if flowType == .pharmacy {
                    navigateToPharmacy = true
                } else if flowType == .labReport {
                    navigateToLabReports = true
                } else if flowType == .doctorBooking {
                    navigateToBookingConfirmation = true
                }
            } label: {
                Text("Pay Now")
                    .font(.headline).fontWeight(.bold).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(Color.blue).clipShape(Capsule())
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 90)
        .background(
            Color(uiColor: .systemBackground)
                .shadow(color: Color.black.opacity(0.06), radius: 15, x: 0, y: -5)
        )
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
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(uiColor: .systemGray6))
                        .frame(width: 48, height: 48)
                    Image(systemName: icon).font(.title3).foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isSelected ? .blue : .gray.opacity(0.3))
            }
            .padding(16)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        PaymentView(
            doctor: Doctor(name: "Dr. Mike Ross", specialty: "Neurologist", rating: 4.8, reviewCount: 90, fee: 180, image: "Image (2)", status: "Available", statusColor: .green, isBookable: true),
            selectedDate: Date(),
            selectedTime: "10:30 AM",
            flowType: .doctorBooking
        )
    }
}
