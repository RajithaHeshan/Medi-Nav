import SwiftUI

struct RegistrationStep2View: View {
    @Environment(\.dismiss) var dismiss
    
    // Form States
    @State private var allergies = ""
    @State private var conditions = ""
    @State private var isTakingMedication = false
    @State private var bloodType = "O Positive"
    
    // Mock Data for Uploads
    @State private var previousReports: [String] = ["Blood_Test.pdf"]
    @State private var currentMedications: [String] = ["Prescription.pdf"]
    
    let bloodTypes = ["A Positive", "A Negative", "B Positive", "B Negative", "O Positive", "O Negative", "AB Positive", "AB Negative"]
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. Navigation Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 2. Progress Bar Section
                        progressSection
                        
                        // 3. Input Fields
                        VStack(spacing: 24) {
                            
                            // Known Allergies
                            MultilineInputField(label: "Known Allergies", placeholder: "List any food, drug, or environmental allergies", text: $allergies)
                            
                            // Chronic Conditions
                            MultilineInputField(label: "Chronic Conditions", placeholder: "e.g., Diabetes, Hypertension, Asthma...", text: $conditions)
                            
                            // Current Medication Toggle
                            VStack(alignment: .leading, spacing: 8) {
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
                            }
                            
                            // Blood Type Native Picker
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
                            
                            // Upload Sections
                            FileUploadSection(title: "Upload Previous Medical Reports", files: $previousReports)
                            
                            FileUploadSection(title: "Upload Current Medication Prescriptions", files: $currentMedications)
                        }
                    }
                    .padding(24)
                    
                    Spacer(minLength: 100) // Keyboard & Button clearance
                }
            }
            
            // 4. Bottom Sticky Action Button
            VStack {
                Spacer()
                Button(action: {
                    // Complete Registration Action
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
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Text("Skip").opacity(0) // Invisible spacer
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
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
        }
    }
}



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
                // Placeholder logic for TextEditor
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
                    
                    // Add Button
                    Button(action: {
                        // Action to open file picker
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.5), style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .frame(width: 80, height: 80)
                                .background(Color.blue.opacity(0.05).clipShape(RoundedRectangle(cornerRadius: 12)))
                            
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundStyle(Color.blue)
                        }
                    }
                    
                    // Uploaded Files
                    ForEach(files.indices, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            
                            // File Thumbnail
                            VStack(spacing: 8) {
                                Image(systemName: "doc.text.fill")
                                    .font(.title)
                                    .foregroundStyle(Color(uiColor: .systemGray3))
                                Text(files[index])
                                    .font(.caption2)
                                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    .lineLimit(1)
                                    .truncationMode(.middle)
                                    .frame(width: 60)
                            }
                            .frame(width: 80, height: 80)
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(uiColor: .systemGray5), lineWidth: 1))
                            
                            // Delete Badge
                            Button(action: {
                                files.remove(at: index)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.red, Color.white)
                                    .font(.system(size: 20))
                                    .offset(x: 6, y: -6)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 4) // Prevents shadow/badge clipping on edges
            }
        }
    }
}

#Preview {
    RegistrationStep2View()
}
