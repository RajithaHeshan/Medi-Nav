import SwiftUI

struct LoginView: View {
    // Form States
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var rememberMe = false
    
   
    @State private var navigateToMainApp = false
    @State private var navigateToRegistration = false
    @State private var navigateToOTP = false
    
    var body: some View {
      
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                
                Color.blue
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        
                        VStack(spacing: 24) {
                            Image("Medi-Nav") 
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                            Text("Explore, Navigate, Success")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 50)
                        
                       
                        VStack(spacing: 24) {
                            
                           
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
                            
                           
                            VStack(spacing: 16) {
                                
                           
                                Button(action: { navigateToMainApp = true }) {
                                    Text("Log In")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 4)
                                }
                                
                                // Divider
                                HStack {
                                    Rectangle().fill(Color(uiColor: .separator)).frame(height: 1)
                                    Text("Or")
                                        .font(.caption)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                        .padding(.horizontal, 8)
                                    Rectangle().fill(Color(uiColor: .separator)).frame(height: 1)
                                }
                                .padding(.vertical, 8)
                                
                               
                                Button(action: { navigateToRegistration = true }) {
                                    Text("Create Account")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.blue)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color(uiColor: .systemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                }
                            }
                            
                            
                            Button(action: { navigateToMainApp = true }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "person.fill")
                                    Text("Continue as Guest")
                                }
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(uiColor: .label))
                                .padding(.vertical, 12)
                                .padding(.horizontal, 24)
                                .background(Color(uiColor: .secondarySystemBackground))
                                .clipShape(Capsule())
                            }
                            .padding(.top, 8)
                            
                            Spacer(minLength: 40)
                        }
                        .padding(30)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(
                            .rect(
                                topLeadingRadius: 32,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 32
                            )
                        )
                        .shadow(color: Color.black.opacity(0.1), radius: 20, y: -5)
                    }
                }
            }
            .navigationBarHidden(true)
            
           
            .navigationDestination(isPresented: $navigateToMainApp) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $navigateToRegistration) {
                RegistrationView()
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
