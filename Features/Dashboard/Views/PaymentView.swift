

//import SwiftUI
//
//// 🔴 CRITICAL: This enum tells the screen which flow we are in
//enum PaymentFlowType {
//    case pharmacy
//    case labReport
//    case doctorBooking
//}
//
//struct PaymentView: View {
//    @Environment(\.dismiss) var dismiss
//    
//    let doctor: Doctor
//    let selectedDate: Date
//    let selectedTime: String
//    
//    // 🔴 CRITICAL: The variable that receives the flow type from the previous screen
//    let flowType: PaymentFlowType
//    
//    @State private var selectedPaymentMethod: Int = 0
//    
//    // Navigation States for both possible destinations
//    @State private var navigateToPharmacy = false
//    @State private var navigateToLabReports = false
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            
//            headerView
//            
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 24) {
//                    
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("APPOINTMENT SUMMARY")
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.secondary)
//                            .padding(.leading, 4)
//                        
//                        appointmentDetailsCard
//                    }
//                    
//                    VStack(alignment: .leading, spacing: 16) {
//                        Text("PAYMENT METHOD")
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.secondary)
//                            .padding(.leading, 4)
//                        
//                        Button {
//                            print("Apple Pay Tapped")
//                        } label: {
//                            HStack(spacing: 8) {
//                                Image(systemName: "apple.logo")
//                                    .font(.title2)
//                                Text("Pay with Apple Pay")
//                                    .fontWeight(.semibold)
//                            }
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 56)
//                            .background(Color.black)
//                            .clipShape(RoundedRectangle(cornerRadius: 16))
//                        }
//                        
//                        PaymentOptionRow(
//                            icon: "creditcard.fill", iconColor: .blue, title: "Credit/Debit Card", subtitle: "Visa, Mastercard, AMEX", isSelected: selectedPaymentMethod == 0
//                        ) { selectedPaymentMethod = 0 }
//                        
//                        PaymentOptionRow(
//                            icon: "shield.fill", iconColor: .gray, title: "Health Insurance", subtitle: "Use provider coverage", isSelected: selectedPaymentMethod == 1
//                        ) { selectedPaymentMethod = 1 }
//                    }
//                    
//                    HStack(alignment: .top, spacing: 12) {
//                        Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue)
//                        Text("Your payment information is encrypted and securely processed by our medical gateway.").font(.caption).foregroundStyle(.blue).fixedSize(horizontal: false, vertical: true)
//                    }
//                    .padding(16).frame(maxWidth: .infinity, alignment: .leading).background(Color.blue.opacity(0.1)).clipShape(RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.2), lineWidth: 1))
//                    
//                    Spacer(minLength: 20)
//                }
//                .padding(20)
//            }
//            
//            bottomFooter
//        }
//        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
//        .navigationBarHidden(true)
//        
//        // 🔴 Dual Navigation Hooks
//        .navigationDestination(isPresented: $navigateToPharmacy) {
//            PharmacyView()
//        }
//        .navigationDestination(isPresented: $navigateToLabReports) {
//            LabReportsView()
//        }
//    }
//    
//    // MARK: - Subviews
//    private var headerView: some View { HStack { Button { dismiss() } label: { Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black) }; Spacer(); Text("Payment").font(.headline).bold(); Spacer(); Image(systemName: "chevron.left").font(.title3).opacity(0) }.padding().background(Color(uiColor: .systemBackground)) }
//    
//    private var appointmentDetailsCard: some View { VStack(spacing: 0) { HStack(spacing: 16) { VStack(alignment: .leading, spacing: 4) { Text(doctor.name).font(.headline); Text(doctor.specialty).font(.subheadline).foregroundStyle(.blue) }; Spacer(); Image(doctor.image).resizable().scaledToFill().frame(width: 50, height: 50).clipShape(RoundedRectangle(cornerRadius: 8)) }.padding(16); Divider().padding(.horizontal, 16); HStack { HStack(spacing: 8) { Image(systemName: "calendar").foregroundStyle(.blue); Text(selectedDate.formatted(date: .abbreviated, time: .omitted)).font(.subheadline).foregroundStyle(.secondary) }; Spacer(); HStack(spacing: 8) { Image(systemName: "clock").foregroundStyle(.blue); Text(selectedTime).font(.subheadline).foregroundStyle(.secondary) } }.padding(16) }.background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4) }
//    
//    private var bottomFooter: some View {
//        VStack(spacing: 16) {
//            Divider()
//            HStack { Text("Total Amount").foregroundStyle(.secondary); Spacer(); Text("$\(doctor.fee).00").font(.title2).bold() }.padding(.horizontal)
//            
//            // 🔴 SMART NAVIGATION LOGIC: Checks the flow type before moving forward
//            Button {
//                if flowType == .pharmacy {
//                    navigateToPharmacy = true
//                } else if flowType == .labReport {
//                    navigateToLabReports = true
//                }
//            } label: {
//                Text("Pay Now").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(Capsule())
//            }
//            .padding(.horizontal).padding(.bottom, 10)
//        }
//        .padding(.top, 16).background(Color(uiColor: .systemBackground).ignoresSafeArea(edges: .bottom)).shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
//    }
//}
//
//// Reusable Component
//struct PaymentOptionRow: View { let icon: String; let iconColor: Color; let title: String; let subtitle: String; let isSelected: Bool; let action: () -> Void; var body: some View { Button(action: action) { HStack(spacing: 16) { ZStack { RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemGray6)).frame(width: 48, height: 48); Image(systemName: icon).font(.title3).foregroundStyle(iconColor) }; VStack(alignment: .leading, spacing: 4) { Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label)); Text(subtitle).font(.caption).foregroundStyle(.secondary) }; Spacer(); Image(systemName: isSelected ? "checkmark.circle.fill" : "circle").font(.title2).foregroundStyle(isSelected ? .blue : .gray.opacity(0.3)) }.padding(16).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)).shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2) }.buttonStyle(.plain) } }



import SwiftUI

enum PaymentFlowType {
    case pharmacy
    case labReport
    case doctorBooking // 🔴 We handle your booking flow here
}

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    
    let doctor: Doctor
    let selectedDate: Date
    let selectedTime: String
    
    let flowType: PaymentFlowType
    
    @State private var selectedPaymentMethod: Int = 0
    
    // Navigation States for all 3 flows
    @State private var navigateToPharmacy = false
    @State private var navigateToLabReports = false
    @State private var navigateToBookingConfirmation = false // 🔴 NEW: For Doctor Booking
    
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
                        
                        PaymentOptionRow(
                            icon: "creditcard.fill", iconColor: .blue, title: "Credit/Debit Card", subtitle: "Visa, Mastercard, AMEX", isSelected: selectedPaymentMethod == 0
                        ) { selectedPaymentMethod = 0 }
                        
                        PaymentOptionRow(
                            icon: "shield.fill", iconColor: .gray, title: "Health Insurance", subtitle: "Use provider coverage", isSelected: selectedPaymentMethod == 1
                        ) { selectedPaymentMethod = 1 }
                    }
                    
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue)
                        Text("Your payment information is encrypted and securely processed by our medical gateway.").font(.caption).foregroundStyle(.blue).fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16).frame(maxWidth: .infinity, alignment: .leading).background(Color.blue.opacity(0.1)).clipShape(RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.2), lineWidth: 1))
                    
                    Spacer(minLength: 20)
                }
                .padding(20)
            }
            
            bottomFooter
        }
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .navigationBarHidden(true)
        
        // 🔴 Routing logic based on flow type
        .navigationDestination(isPresented: $navigateToPharmacy) {
            PharmacyView()
        }
        .navigationDestination(isPresented: $navigateToLabReports) {
            LabReportsView()
        }
        .navigationDestination(isPresented: $navigateToBookingConfirmation) {
            // 🔴 Navigates to the screen you just built
            PaymentConfirmationView(
                doctor: doctor,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                fee: doctor.fee
            )
        }
    }
    
    // MARK: - Subviews
    private var headerView: some View { HStack { Button { dismiss() } label: { Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black) }; Spacer(); Text("Payment").font(.headline).bold(); Spacer(); Image(systemName: "chevron.left").font(.title3).opacity(0) }.padding().background(Color(uiColor: .systemBackground)) }
    
    private var appointmentDetailsCard: some View { VStack(spacing: 0) { HStack(spacing: 16) { VStack(alignment: .leading, spacing: 4) { Text(doctor.name).font(.headline); Text(doctor.specialty).font(.subheadline).foregroundStyle(.blue) }; Spacer(); Image(doctor.image).resizable().scaledToFill().frame(width: 50, height: 50).clipShape(RoundedRectangle(cornerRadius: 8)) }.padding(16); Divider().padding(.horizontal, 16); HStack { HStack(spacing: 8) { Image(systemName: "calendar").foregroundStyle(.blue); Text(selectedDate.formatted(date: .abbreviated, time: .omitted)).font(.subheadline).foregroundStyle(.secondary) }; Spacer(); HStack(spacing: 8) { Image(systemName: "clock").foregroundStyle(.blue); Text(selectedTime).font(.subheadline).foregroundStyle(.secondary) } }.padding(16) }.background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4) }
    
    private var bottomFooter: some View {
        VStack(spacing: 16) {
            Divider()
            HStack { Text("Total Amount").foregroundStyle(.secondary); Spacer(); Text("$\(doctor.fee).00").font(.title2).bold() }.padding(.horizontal)
            
            // 🔴 Evaluates the flowType to decide which screen opens next
            Button {
                if flowType == .pharmacy {
                    navigateToPharmacy = true
                } else if flowType == .labReport {
                    navigateToLabReports = true
                } else if flowType == .doctorBooking {
                    navigateToBookingConfirmation = true
                }
            } label: {
                Text("Pay Now").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(Capsule())
            }
            .padding(.horizontal).padding(.bottom, 10)
        }
        .padding(.top, 16).background(Color(uiColor: .systemBackground).ignoresSafeArea(edges: .bottom)).shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
    }
}

struct PaymentOptionRow: View { let icon: String; let iconColor: Color; let title: String; let subtitle: String; let isSelected: Bool; let action: () -> Void; var body: some View { Button(action: action) { HStack(spacing: 16) { ZStack { RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemGray6)).frame(width: 48, height: 48); Image(systemName: icon).font(.title3).foregroundStyle(iconColor) }; VStack(alignment: .leading, spacing: 4) { Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label)); Text(subtitle).font(.caption).foregroundStyle(.secondary) }; Spacer(); Image(systemName: isSelected ? "checkmark.circle.fill" : "circle").font(.title2).foregroundStyle(isSelected ? .blue : .gray.opacity(0.3)) }.padding(16).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)).shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2) }.buttonStyle(.plain) } }
