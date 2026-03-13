import SwiftUI

struct RegistrationStep2View: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var allergies = ""
    @State private var conditions = ""
    @State private var isTakingMedication = false
    @State private var bloodType = "O Positive"
    
    @State private var previousReports: [String] = ["Blood_Test.pdf"]
    @State private var currentMedications: [String] = ["Prescription.pdf"]
    
    // Navigation State
    @State private var navigateToLogin = false
    
    let bloodTypes = ["A Positive", "A Negative", "B Positive", "B Negative", "O Positive", "O Negative", "AB Positive", "AB Negative"]
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        progressSection
                        
                        VStack(spacing: 24) {
                            MultilineInputField(label: "Known Allergies", placeholder: "List any food, drug, or environmental allergies", text: $allergies)
                            
                            MultilineInputField(label: "Chronic Conditions", placeholder: "e.g., Diabetes, Hypertension, Asthma...", text: $conditions)
                            
                            Toggle(isOn: $isTakingMedication) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Current Medication")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(uiColor: .label))
                                    
                                    Text("Are you currently taking any prescription medication?")
                                        .font(.caption)
                                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                                }
                            }
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Blood Type")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(uiColor: .label))
                                
                                Menu {
                                    Picker("Blood Type", selection: $bloodType) {
                                        ForEach(bloodTypes, id: \.self) { type in
                                            Text(type).tag(type)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(bloodType)
                                            .font(.body)
                                            .foregroundStyle(Color(uiColor: .label))
                                        Spacer()
                                        Image(systemName: "chevron.up.chevron.down")
                                            .font(.caption)
                                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    }
                                    .padding()
                                    .background(Color(uiColor: .secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            
                            FileUploadSection(title: "Upload Medical Reports", files: $previousReports)
                            
                            FileUploadSection(title: "Upload Prescriptions", files: $currentMedications)
                        }
                    }
                    .padding(24)
                    
                    Spacer(minLength: 120)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            
            // Sticky Bottom Button
            VStack {
                Spacer()
                Button(action: {
                    // 🔴 TRIGGERS NAVIGATION TO LOGIN
                    navigateToLogin = true
                }) {
                    Text("Complete Registration")
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
        
        // 🔴 NAVIGATION DESTINATION
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color.blue)
            }
            Spacer()
            Text("Registration")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            Spacer()
            Button("Skip") { dismiss() }
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.blue)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
    
    private var progressSection: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom) {
                Text("Medical Details")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Spacer()
                Text("Step 2 of 2")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
            Capsule()
                .fill(Color.blue)
                .frame(height: 6)
            
            HStack {
                Spacer()
                Text("100%")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
            }
        }
    }
}

// MARK: - Local Components

struct MultilineInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(Color(uiColor: .placeholderText))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .zIndex(1)
                        .allowsHitTesting(false)
                }
                
                TextEditor(text: $text)
                    .font(.body)
                    .frame(minHeight: 100)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .scrollContentBackground(.hidden)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

struct FileUploadSection: View {
    let title: String
    @Binding var files: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Button(action: { }) {
                        VStack {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundStyle(Color.blue)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color.blue.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.3), style: StrokeStyle(lineWidth: 1, dash: [5]))
                        )
                    }
                    
                    ForEach(files, id: \.self) { file in
                        ZStack(alignment: .topTrailing) {
                            VStack(spacing: 8) {
                                Image(systemName: "doc.text.fill")
                                    .font(.title)
                                    .foregroundStyle(Color.blue.opacity(0.6))
                                Text(file)
                                    .font(.caption2)
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    .lineLimit(1)
                                    .frame(width: 60)
                            }
                            .frame(width: 80, height: 80)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Button(action: {
                                if let index = files.firstIndex(of: file) {
                                    files.remove(at: index)
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red, .white)
                                    .offset(x: 5, y: -5)
                            }
                        }
                    }
                }
                .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationStep2View()
    }
}
