

import SwiftUI

struct OTPVerificationView: View {
    @Environment(\.dismiss) var dismiss
    
   
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    @State private var timeRemaining = 59
    @State private var timer: Timer? = nil
    
   
    @State private var navigateToNewPassword = false
    
    let otpLength = 6
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                       
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Enter OTP Code")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(uiColor: .label))
                            
                            Text("We have sent a 6-digit code to your mobile number")
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineSpacing(4)
                        }
                        
                        otpInputSection
                        
                        resendSection
                    }
                    .padding(24)
                    
                    Spacer(minLength: 100)
                }
            }
            
          
            VStack {
                Spacer()
                Button(action: {
                   
                    navigateToNewPassword = true
                }) {
                    Text("Verify & Proceed")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(otpText.count == otpLength ? Color.blue : Color.blue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: otpText.count == otpLength ? Color.blue.opacity(0.3) : .clear, radius: 8, y: 4)
                }
                .disabled(otpText.count != otpLength)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
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
       
        .navigationDestination(isPresented: $navigateToNewPassword) {
            NewPasswordView()
        }
        .onAppear {
            startTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isKeyboardShowing = true
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
   
    
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.blue)
                        .offset(x: -1.5)
                }
            }
            Spacer()
            Text("Verification")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40)
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
    
    private var otpInputSection: some View {
        ZStack {
            HStack(spacing: 12) {
                ForEach(0..<otpLength, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(uiColor: .secondarySystemBackground))
                            .frame(height: 60)
                        
                        if otpText.count == index {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                        
                        Text(getPinDigit(at: index))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            
            TextField("", text: $otpText)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isKeyboardShowing)
                .foregroundStyle(.clear)
                .tint(.clear)
                .onChange(of: otpText) { _, newValue in
                    if newValue.count > otpLength {
                        otpText = String(newValue.prefix(otpLength))
                    }
                }
        }
    }
    
    private var resendSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Did not receive the code?")
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            
            if timeRemaining > 0 {
                Text("Resend in \(String(format: "0:%02d", timeRemaining))")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .tertiaryLabel))
            } else {
                Button(action: {
                    timeRemaining = 59
                    startTimer()
                }) {
                    Text("Resend Code")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                }
            }
        }
    }
    
  
    
    private func getPinDigit(at index: Int) -> String {
        guard otpText.count > index else { return "" }
        let stringIndex = otpText.index(otpText.startIndex, offsetBy: index)
        return String(otpText[stringIndex])
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}



#Preview {
    NavigationStack {
        OTPVerificationView()
    }
}
