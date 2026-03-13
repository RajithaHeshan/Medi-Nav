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
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16)
                            .padding(.bottom, 24)
                        
                     
                        VStack(spacing: 20) {
                            
                        
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
                                Button(action: { rememberMe.toggle() }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(rememberMe ? Color.blue : Color(uiColor: .systemGray3))
                                        
                                        Text("Remember me")
                                            .font(.subheadline)
                                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    }
                                }
                                
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
                                    .frame(height: 56)
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
                                navigateToRegistration = true
                            }) {
                                Text("Create Account")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.blue)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(Color(uiColor: .systemBackground))
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.blue, lineWidth: 1.5))
                            }
                            
                          
                            Button(action: {
                               
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "apple.logo")
                                        .font(.title2)
                                        .foregroundStyle(Color(uiColor: .label))
                                        .offset(y: -2)
                                    
                                    Text("Continue with Apple")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(uiColor: .label))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                            }
                            
                            // Google Button
                            Button(action: {
                                // Google Auth Action
                            }) {
                                HStack(spacing: 12) {
                                    Text("G")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(
                                            LinearGradient(colors: [.blue, .red, .yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                    
                                    Text("Continue with Google")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color(uiColor: .label))
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color(uiColor: .systemBackground))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                            }
                            
                            
                            Button(action: {
                                navigateToMainApp = true
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "person.fill")
                                    Text("Continue as Guest")
                                }
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .padding(.vertical, 16)
                            }
                            .padding(.top, 8)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40) 
                    }
                }
            }
            .navigationBarHidden(true)
            
           
            .navigationDestination(isPresented: $navigateToRegistration) {
                RegistrationView()
            }
            .fullScreenCover(isPresented: $navigateToMainApp) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
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
