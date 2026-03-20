
import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var rememberMe = false
    
    @State private var navigateToMainApp = false
    @State private var navigateToRegistration = false
    @State private var navigateToOTP = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Image("NewLogin")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 220)
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                        
                        VStack(spacing: 16) {
                            
                       
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Username")
                                    .font(.subheadline)
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                
                                TextField("Enter your username", text: $username)
                                    .font(.body)
                                    .padding()
                                    .background(Color(uiColor: .secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                           
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.subheadline)
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                
                                HStack {
                                    if isPasswordVisible {
                                        TextField("Enter your password", text: $password)
                                    } else {
                                        SecureField("Enter your password", text: $password)
                                    }
                                    
                                    Button(action: { isPasswordVisible.toggle() }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundStyle(Color(uiColor: .systemGray3))
                                    }
                                }
                                .padding()
                                .background(Color(uiColor: .secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                        
                            HStack {
                                Toggle(isOn: $rememberMe) {
                                    Text("Remember me")
                                        .font(.subheadline)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                }
                                .tint(.blue)
                                .fixedSize()
                                
                                Spacer()
                                
                                Button(action: { navigateToOTP = true }) {
                                    Text("Forgot Password?")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.blue)
                                }
                            }
                            .padding(.top, -4)
                            
                         
                            Button(action: {
                                navigateToMainApp = true
                            }) {
                                Text("Log In")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                                    .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 4)
                            }
                            .padding(.top, 8)
                            
                        
                            HStack {
                                Rectangle().fill(Color(uiColor: .separator)).frame(height: 1)
                                Text("Or")
                                    .font(.caption)
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    .padding(.horizontal, 8)
                                Rectangle().fill(Color(uiColor: .separator)).frame(height: 1)
                            }
                            .padding(.vertical, 8)
                            
                            
                     
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "apple.logo")
                                        .font(.title3)
                                        .foregroundStyle(Color(uiColor: .label))
                                        .offset(y: -2)
                                    
                                    Text("Continue with Apple")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(uiColor: .label))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                            }
                            
                        
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 8) {
                                    Text("G")
                                        .font(.headline)
                                        .fontWeight(.black)
                                        .foregroundStyle(
                                            LinearGradient(colors: [.blue, .red, .yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                    Text("Continue with Google")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(uiColor: .label))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                            }
                            
                      
                            Button(action: {
                                navigateToMainApp = true
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: "person.fill")
                                    Text("Continue as Guest")
                                }
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .padding(.top, 4)
                            }
                            
                            Spacer(minLength: 24)
                            
                          
                            Button(action: {
                                navigateToRegistration = true
                            }) {
                                HStack(spacing: 4) {
                                    Text("Don't have an account?")
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    Text("Sign Up")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.blue)
                                }
                                .font(.subheadline)
                            }
                            .padding(.bottom, 16)
                            
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationBarHidden(true)
            
            .navigationDestination(isPresented: $navigateToRegistration) {
                RegistrationView()
            }
            .fullScreenCover(isPresented: $navigateToMainApp) {
                ContentView()
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPSendView()
            }
        }
    }
}

#Preview {
    LoginView()
}
