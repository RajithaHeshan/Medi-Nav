import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName = ""
    @State private var emailAddress = ""
    @State private var phoneNumber = ""
    @State private var dateOfBirth = Date()
    
    @State private var navigateToStep2 = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {
                            progressSection
                            
                            Text("Please fill in your personal details to create your Medi-Nav account. We will keep your information secure.")
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineSpacing(4)
                            
                            VStack(spacing: 20) {
                                RegistrationInputField(label: "Full Name", placeholder: "Enter your full name", text: $fullName)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Date of Birth")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(uiColor: .label))
                                    
                                    HStack {
                                        Text("Select your DOB")
                                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                                        Spacer()
                                        DatePicker("", selection: $dateOfBirth, displayedComponents: .date)
                                            .labelsHidden()
                                            .environment(\.locale, Locale(identifier: "en_US"))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(uiColor: .secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                
                                RegistrationInputField(label: "Email Address", placeholder: "Enter your email", text: $emailAddress, keyboardType: .emailAddress)
                                
                                RegistrationInputField(label: "Phone Number", placeholder: "Enter your phone number", text: $phoneNumber, keyboardType: .phonePad)
                            }
                        }
                        .padding(24)
                        Spacer(minLength: 120)
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
                
              
                VStack {
                    Spacer()
                    Button(action: {
                        
                        navigateToStep2 = true
                    }) {
                        Text("Next Step")
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
                    .background(
                        LinearGradient(colors: [Color(uiColor: .systemBackground).opacity(0), Color(uiColor: .systemBackground)], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                    )
                }
            }
            .navigationBarHidden(true)
            
       
            .navigationDestination(isPresented: $navigateToStep2) {
                RegistrationStep2View()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
  
    
    private var headerView: some View {
        HStack {
            Text("Skip").opacity(0).padding(.horizontal, 12)
            Spacer()
            Text("Registration").font(.title2).fontWeight(.bold)
            Spacer()
            Button("Skip") { dismiss() }
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.blue)
                .padding(8)
        }
        .padding(.horizontal, 12).padding(.top, 16)
    }
    
    private var progressSection: some View {
        VStack(spacing: 12) {
            HStack(alignment: .bottom) {
                Text("Personal Details").font(.title3).fontWeight(.bold)
                Spacer()
                Text("Step 1 of 2").font(.subheadline).foregroundStyle(.secondary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.blue.opacity(0.15)).frame(height: 6)
                    Capsule().fill(Color.blue).frame(width: geo.size.width * 0.5, height: 6)
                }
            }.frame(height: 6)
        }
    }
}



struct RegistrationInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(keyboardType == .emailAddress ? .never : .words)
                .autocorrectionDisabled(keyboardType == .emailAddress)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    RegistrationView()
}
