import SwiftUI

struct NewPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
  
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isNewPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
 
    @State private var navigateToLogin = false
    
   
    var isPasswordLongEnough: Bool { newPassword.count >= 8 }
    var passwordsMatch: Bool { !newPassword.isEmpty && newPassword == confirmPassword }
    var isFormValid: Bool { isPasswordLongEnough && passwordsMatch }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                       
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Create New Password")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(uiColor: .label))
                            
                            Text("Your new password must be different from previously used passwords to ensure account security.")
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineSpacing(4)
                        }
                        
                  
                        VStack(spacing: 20) {
                            PasswordInputField(
                                label: "New Password",
                                placeholder: "Enter Password",
                                text: $newPassword,
                                isVisible: $isNewPasswordVisible
                            )
                            
                            PasswordInputField(
                                label: "Confirm Password",
                                placeholder: "Confirm Password",
                                text: $confirmPassword,
                                isVisible: $isConfirmPasswordVisible
                            )
                            
                       
                            VStack(alignment: .leading, spacing: 8) {
                                validationRow(text: "Minimum 8 characters", isValid: isPasswordLongEnough)
                                validationRow(text: "Passwords must match", isValid: passwordsMatch)
                            }
                            .padding(.top, 4)
                        }
                    }
                    .padding(24)
                    
                    Spacer(minLength: 100)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            
         
            VStack {
                Spacer()
                Button(action: {
               
                    navigateToLogin = true
                }) {
                    Text("Update Password")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(isFormValid ? Color.blue : Color.blue.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: isFormValid ? Color.blue.opacity(0.3) : .clear, radius: 8, y: 4)
                }
                .disabled(!isFormValid)
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
     
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView()
                .navigationBarBackButtonHidden(true)
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
            Text("New Password")
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
    
    private func validationRow(text: String, isValid: Bool) -> some View {
        HStack(spacing: 8) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isValid ? .green : Color(uiColor: .systemGray4))
            
            Text(text)
                .font(.caption)
                .foregroundStyle(isValid ? Color(uiColor: .label) : Color(uiColor: .secondaryLabel))
        }
    }
}


struct PasswordInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            HStack {
                if isVisible {
                    TextField(placeholder, text: $text)
                        .font(.body)
                } else {
                    SecureField(placeholder, text: $text)
                        .font(.body)
                }
                
                Button(action: { isVisible.toggle() }) {
                    Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    NavigationStack {
        NewPasswordView()
    }
}
