import SwiftUI

struct OTPSendView: View {
    @Environment(\.dismiss) var dismiss
    @State private var phoneNumber = ""
    
    var body: some View {
        ZStack {
            // Native Background
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. Navigation Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // 2. Title & Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Reset Password")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(uiColor: .label))
                            
                            Text("Enter the mobile number associated with your account and we will send you a verification code via SMS.")
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineSpacing(4)
                        }
                        .padding(.top, 16)
                        
                        // 3. Input Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mobile Number")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(uiColor: .label))
                            
                            HStack {
                                TextField("+1 234 567 890", text: $phoneNumber)
                                    .font(.body)
                                    // 🔴 HIG FIX: Forces the Number Pad and allows iOS to auto-suggest the user's phone number!
                                    .keyboardType(.phonePad)
                                    .textContentType(.telephoneNumber)
                                
                                Image(systemName: "iphone")
                                    .font(.title3)
                                    .foregroundStyle(Color(uiColor: .systemGray3))
                            }
                            .padding()
                            // 🔴 HIG FIX: Modern borderless iOS fill
                            .background(Color(uiColor: .secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Keyboard & Button clearance
                    Spacer(minLength: 120)
                }
            }
            
            // 4. Bottom Sticky Action Button
            VStack {
                Spacer()
                Button(action: {
                    // Action to request OTP / Navigate to OTP Verification View
                }) {
                    Text("Get OTP Code")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                // Gradient fade so scrolling text disappears cleanly behind the button
                .background(
                    LinearGradient(
                        colors: [Color(uiColor: .systemBackground).opacity(0), Color(uiColor: .systemBackground)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                )
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            // 🔴 HIG FIX: Added missing back button so the user isn't trapped
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
            
            Text("Verify Phone")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40) // Visually center the text against the back button
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    OTPSendView()
}

