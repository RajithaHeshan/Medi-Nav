import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct DoctorConsultationView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showPrescriptionSheet = false
    @State private var showLabReportSheet = false
    @State private var showAttachModal = false
    
    @State private var showCamera = false
    @State private var showFilePicker = false
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var attachedFileName: String?
    
    @State private var navigateToPrescription = false
    @State private var navigateToMedicationPickup = false
    @State private var navigateToLabSampleSubmission = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        doctorProfileCard
                            .padding(.horizontal, 20)
                        
                        visitDoctorQueueCard
                            .padding(.horizontal, 20)
                        
                      
                        nextStepsCarousel
                        
                        vitalsOverviewSection
                            .padding(.horizontal, 20)
                        prescriptionsSection
                            .padding(.horizontal, 20)
                        labReportsSection
                            .padding(.horizontal, 20)
                        
                        Spacer(minLength: 60)
                    }
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
        
        .navigationDestination(isPresented: $navigateToPrescription) {
            PrescriptionView()
        }
        
        .navigationDestination(isPresented: $navigateToMedicationPickup) {
            MedicationPickupView()
        }
        
        .navigationDestination(isPresented: $navigateToLabSampleSubmission) {
            LaboratorySampleSubmissionView()
        }
        
        .sheet(isPresented: $showPrescriptionSheet) {
            PrescriptionDetailsSheet(
                showAttachModal: $showAttachModal,
                onClinicPharmacyTapped: {
                    navigateToMedicationPickup = true
                }
            )
            .presentationDetents([.fraction(0.85), .large])
            .presentationDragIndicator(.visible)
        }
        
        .sheet(isPresented: $showLabReportSheet) {
            LabReportSampleSheet(
                showAttachModal: $showAttachModal,
                onClinicLaboratoryTapped: {
                    navigateToLabSampleSubmission = true
                }
            )
            .presentationDetents([.fraction(0.85), .large])
            .presentationDragIndicator(.visible)
        }
        
        .sheet(isPresented: $showAttachModal) {
            CustomAttachMenuSheet(
                selectedPhotoItem: $selectedPhotoItem,
                onCameraTapped: { showCamera = true },
                onFileTapped: { showFilePicker = true },
                onUploadTapped: { navigateToPrescription = true }
            )
            .presentationDetents([.height(350)])
            .presentationDragIndicator(.visible)
        }
        
        .fullScreenCover(isPresented: $showCamera) {
            CameraCaptureView(image: $selectedImage).ignoresSafeArea()
        }
        
        .fileImporter(isPresented: $showFilePicker, allowedContentTypes: [.pdf, .image, .plainText], allowsMultipleSelection: false) { result in
            switch result {
            case .success(let urls):
                if let selectedFile = urls.first {
                    if selectedFile.startAccessingSecurityScopedResource() {
                        attachedFileName = selectedFile.lastPathComponent
                        selectedFile.stopAccessingSecurityScopedResource()
                    }
                }
            case .failure(let error):
                print("Failed to select file: \(error.localizedDescription)")
            }
        }
        
        .onChange(of: selectedPhotoItem) { _ in
            if selectedPhotoItem != nil {
                attachedFileName = "Selected from Photo Library"
            }
        }
        .onChange(of: selectedImage) { _ in
            if selectedImage != nil {
                attachedFileName = "Captured from Camera"
            }
        }
    }
    
   
    
    private var headerView: some View {
        HStack(spacing: 16) {
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
            
            Text("Doctor Consultation")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var doctorProfileCard: some View {
        HStack(spacing: 16) {
            Image("doctor1")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .background(Color(uiColor: .systemGray5))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.1), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Dr. Sarah Jenkins")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("General Practitioner")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Text("Visit Date: Oct 24, 2025")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .systemGray3))
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var visitDoctorQueueCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Visit Doctor")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Text("10:30 AM")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("DR. Wickrama").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            // Queue & Time Info Box
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill").foregroundStyle(Color.blue)
                    Text("5 Queue").font(.subheadline).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                
                Divider().frame(height: 24)
                
                HStack(spacing: 8) {
                    Image(systemName: "hourglass").foregroundStyle(Color.orange)
                    Text("15 mins").font(.subheadline).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 14)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
           
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button(action: { }) {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding(.vertical, 8)
                    .padding(.leading, 8)
                    .contentShape(Rectangle())
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    

    private var nextStepsCarousel: some View {
        TabView {
            nextStepPharmacyCard
                .padding(.horizontal, 20)
               
                .padding(.bottom, 12)
            
            nextStepLaboratoryCard
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
     
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      
        .frame(height: 250)
    }
    
    private var nextStepPharmacyCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Step: Visit Pharmacy")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("DR. Wickrama").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            if let fileName = attachedFileName {
                HStack {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                    Text("Attached: \(fileName)").font(.caption).fontWeight(.semibold).lineLimit(1)
                }
                .padding(.top, 4)
            }
            
            Button {
                showPrescriptionSheet = true
            } label: {
                HStack(spacing: 8) {
                    Text("Check In to Pharmacy").fontWeight(.semibold)
                    Image(systemName: "qrcode.viewfinder")
                }
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(uiColor: .systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.top, 4)
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button {
                    
                } label: {
                    Text("View Map")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                        .contentShape(Rectangle())
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
   
    private var nextStepLaboratoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Step: Visit Laboratory")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("DR. Wickrama").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            Button {
                showLabReportSheet = true
            } label: {
               
                HStack(spacing: 0) {
                    Text("Provide Sample").fontWeight(.semibold)
                }
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(uiColor: .systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.top, 4)
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button {
                    
                } label: {
                    Text("View Map")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                        .contentShape(Rectangle())
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var vitalsOverviewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Vitals Overview", actionText: "ALL")
            
            HStack(spacing: 16) {
                VitalsCard(statusIcon: "checkmark.circle.fill", statusColor: Color(uiColor: .systemGreen), statusText: "Normal", title: "Blood Pressure", value: "120/80", unit: "mmHg", progress: 0.6)
                VitalsCard(statusIcon: "checkmark.circle.fill", statusColor: Color(uiColor: .systemGreen), statusText: "Normal", title: "Heart Rate", value: "72", unit: "BPM", progress: 0.4)
            }
        }
    }
    
    private var prescriptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Prescriptions", actionText: "ALL")
            
            VStack(spacing: 12) {
                ConsultationItemRow(icon: "pills.fill", iconColor: Color(uiColor: .systemBlue), iconBgColor: Color(uiColor: .systemBlue).opacity(0.1), title: "Amoxicillin 500mg", subtitle: "Take 1 tablet twice daily")
                ConsultationItemRow(icon: "cross.vial.fill", iconColor: Color(uiColor: .systemBlue), iconBgColor: Color(uiColor: .systemBlue).opacity(0.1), title: "Paracetamol", subtitle: "Take 1 tablet twice daily")
            }
        }
    }
    
    private var labReportsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Lab Reports", actionText: "ALL")
            
            VStack(spacing: 12) {
                ConsultationItemRow(icon: "testtube.2", iconColor: Color(uiColor: .systemPurple), iconBgColor: Color(uiColor: .systemPurple).opacity(0.1), title: "MRI Radiology", subtitle: "Diagnostic Imaging")
                ConsultationItemRow(icon: "lungs.fill", iconColor: Color(uiColor: .systemRed), iconBgColor: Color(uiColor: .systemRed).opacity(0.1), title: "Lung Report", subtitle: "Pulmonary Function Test")
            }
        }
    }
}



struct LabReportSampleSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showAttachModal: Bool
    var onClinicLaboratoryTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack { Text("Lab Report Sample Details").font(.title3).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Spacer(); Button { dismiss() } label: { Image(systemName: "xmark").font(.body.bold()).foregroundStyle(Color(uiColor: .secondaryLabel)).padding(8) } }.padding(.horizontal, 20).padding(.top, 24).padding(.bottom, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Report samples (2)").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                        
                        PrescribedMedicationRow(icon: "brain", iconColor: Color(uiColor: .systemBlue), title: "MRI Radiology", badgeText: "ANTIBIOTIC", badgeColor: Color(uiColor: .systemBlue), dosageInfo: "500mg • 20 Capsules", instructions: "Take 1 tablet every 12 hours after food")
                        PrescribedMedicationRow(icon: "lungs", iconColor: Color(uiColor: .systemBlue), title: "Lung Report", badgeText: "PAIN RELIEF", badgeColor: Color(uiColor: .systemGreen), dosageInfo: "500mg • 10 Tablets", instructions: "Take 1 tablet every 6 hours if needed")
                    }
                    
                    VStack(spacing: 16) {
                        PharmacyRoutingButton(title: "Sample at Clinic Laboratory", subtitle: "Generate QR code & join internal queue", icon: "qrcode.viewfinder", isPrimary: true) {
                            dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onClinicLaboratoryTapped()
                            }
                        }
                        
                        PharmacyRoutingButton(title: "Sample at Outside Laboratory", subtitle: "Attach lab report file or photo", icon: "link", isPrimary: false) {
                            dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { showAttachModal = true }
                        }
                    }.padding(.top, 8)
                }.padding(.horizontal, 20).padding(.bottom, 40)
            }
        }.background(Color(uiColor: .systemBackground))
    }
}

struct PrescriptionDetailsSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showAttachModal: Bool
    var onClinicPharmacyTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack { Text("Prescription Details").font(.title3).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Spacer(); Button { dismiss() } label: { Image(systemName: "xmark").font(.body.bold()).foregroundStyle(Color(uiColor: .secondaryLabel)).padding(8) } }.padding(.horizontal, 20).padding(.top, 24).padding(.bottom, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) { Text("Medications Prescribed (2)").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel)); PrescribedMedicationRow(icon: "pills.fill", iconColor: Color(uiColor: .systemBlue), title: "Amoxicillin", badgeText: "ANTIBIOTIC", badgeColor: Color(uiColor: .systemBlue), dosageInfo: "500mg • 20 Capsules", instructions: "Take 1 tablet every 12 hours after food"); PrescribedMedicationRow(icon: "cross.vial.fill", iconColor: Color(uiColor: .systemBlue), title: "Paracetamol", badgeText: "PAIN RELIEF", badgeColor: Color(uiColor: .systemGreen), dosageInfo: "500mg • 10 Tablets", instructions: "Take 1 tablet every 6 hours if needed") }
                    
                    VStack(spacing: 16) {
                        PharmacyRoutingButton(title: "Get at Clinic Pharmacy", subtitle: "Generate QR code & join internal queue", icon: "qrcode.viewfinder", isPrimary: true) { dismiss(); DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { onClinicPharmacyTapped() } }
                        PharmacyRoutingButton(title: "Get at Outside Pharmacy", subtitle: "Attach prescription file or photo", icon: "link", isPrimary: false) { dismiss(); DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { showAttachModal = true } }
                    }.padding(.top, 8)
                }.padding(.horizontal, 20).padding(.bottom, 40)
            }
        }.background(Color(uiColor: .systemBackground))
    }
}

struct CustomAttachMenuSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedPhotoItem: PhotosPickerItem?
    
    var onCameraTapped: () -> Void
    var onFileTapped: () -> Void
    var onUploadTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 6) { Text("Select Photo").font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Text("Choose how you'd like to add a photo").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel)).multilineTextAlignment(.center) }.padding(.top, 24).padding(.bottom, 8)
            
            VStack(spacing: 0) {
                ModalMenuButton(title: "Camera", icon: "camera.fill") { dismiss(); DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { onCameraTapped() } }
                Divider()
                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) { HStack(spacing: 16) { Image(systemName: "photo.fill").font(.title3).foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 24); Text("Photo Library").font(.headline).foregroundStyle(Color(uiColor: .label)); Spacer(); Image(systemName: "chevron.right").font(.subheadline).foregroundStyle(Color(uiColor: .systemGray3)) }.padding().background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2) }.onChange(of: selectedPhotoItem) { _ in dismiss() }
                Divider()
                ModalMenuButton(title: "File Manager", icon: "folder.fill") { dismiss(); DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { onFileTapped() } }
            }.background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16))
            
            Button { dismiss(); DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { onUploadTapped() } } label: { Text("Upload").font(.title3).fontWeight(.bold).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(Color(uiColor: .systemBlue)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color(uiColor: .systemBlue).opacity(0.3), radius: 8, x: 0, y: 4) }
            
            Spacer()
        }.padding(.horizontal, 16).background(Color(uiColor: .systemGroupedBackground))
    }
}

struct CameraCaptureView: UIViewControllerRepresentable { @Binding var image: UIImage?; @Environment(\.presentationMode) var presentationMode; func makeUIViewController(context: Context) -> UIImagePickerController { let picker = UIImagePickerController(); picker.delegate = context.coordinator; picker.sourceType = .camera; return picker }; func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}; func makeCoordinator() -> Coordinator { Coordinator(self) }; class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate { let parent: CameraCaptureView; init(_ parent: CameraCaptureView) { self.parent = parent }; func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { if let uiImage = info[.originalImage] as? UIImage { parent.image = uiImage }; parent.presentationMode.wrappedValue.dismiss() } } }

struct ModalMenuButton: View { let title: String; let icon: String; let action: () -> Void; var body: some View { Button(action: action) { HStack(spacing: 16) { Image(systemName: icon).font(.title3).foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 24); Text(title).font(.headline).foregroundStyle(Color(uiColor: .label)); Spacer(); Image(systemName: "chevron.right").font(.subheadline).foregroundStyle(Color(uiColor: .systemGray3)) }.padding().background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2) } } }

struct PrescribedMedicationRow: View { let icon: String; let iconColor: Color; let title: String; let badgeText: String; let badgeColor: Color; let dosageInfo: String; let instructions: String; var body: some View { HStack(alignment: .top, spacing: 16) { ZStack { RoundedRectangle(cornerRadius: 12).fill(Color(uiColor: .secondarySystemGroupedBackground)).frame(width: 48, height: 48).shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2); Image(systemName: icon).font(.title3).foregroundStyle(iconColor) }; VStack(alignment: .leading, spacing: 8) { HStack { Text(title).font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Spacer(); Text(badgeText).font(.system(size: 10, weight: .bold)).foregroundStyle(badgeColor).padding(.horizontal, 8).padding(.vertical, 4).background(badgeColor.opacity(0.1)).clipShape(Capsule()) }; Text(dosageInfo).font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel)); HStack(spacing: 8) { Image(systemName: "clock").foregroundStyle(Color(uiColor: .tertiaryLabel)); Text(instructions).foregroundStyle(Color(uiColor: .secondaryLabel)) }.font(.caption).padding(.horizontal, 12).padding(.vertical, 8).frame(maxWidth: .infinity, alignment: .leading).background(Color(uiColor: .secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 8)) } } } }

struct PharmacyRoutingButton: View { let title: String; let subtitle: String; let icon: String; let isPrimary: Bool; let action: () -> Void; var body: some View { Button(action: action) { HStack(spacing: 16) { Image(systemName: icon).font(.title2).foregroundStyle(isPrimary ? .white : Color(uiColor: .systemBlue)).frame(width: 30); VStack(alignment: .leading, spacing: 2) { Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(isPrimary ? .white : Color(uiColor: .label)); Text(subtitle).font(.caption).foregroundStyle(isPrimary ? .white.opacity(0.8) : Color(uiColor: .secondaryLabel)) }; Spacer(); Image(systemName: "chevron.right").font(.subheadline).foregroundStyle(isPrimary ? .white : Color(uiColor: .systemGray3)) }.padding().background(isPrimary ? Color(uiColor: .systemBlue) : Color(uiColor: .secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: isPrimary ? Color(uiColor: .systemBlue).opacity(0.3) : Color.clear, radius: 8, x: 0, y: 4) }.buttonStyle(PlainButtonStyle()) } }

struct SectionHeader: View { let title: String; let actionText: String; var body: some View { HStack { Text(title).font(.title3).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Spacer(); Button(actionText) { }.font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .systemBlue)).padding(.vertical, 8).padding(.leading, 8).contentShape(Rectangle()) } } }

struct VitalsCard: View { let statusIcon: String; let statusColor: Color; let statusText: String; let title: String; let value: String; let unit: String; let progress: Double; var body: some View { VStack(alignment: .leading, spacing: 12) { HStack { ZStack { Circle().fill(statusColor.opacity(0.1)).frame(width: 28, height: 28); Image(systemName: statusIcon).font(.caption).foregroundStyle(statusColor) }; Spacer(); Text(statusText).font(.caption2).fontWeight(.semibold).foregroundStyle(Color(uiColor: .secondaryLabel)) }; VStack(alignment: .leading, spacing: 4) { Text(title).font(.caption).foregroundStyle(Color(uiColor: .secondaryLabel)); HStack(alignment: .firstTextBaseline, spacing: 2) { Text(value).font(.title2).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Text(unit).font(.caption2).foregroundStyle(Color(uiColor: .tertiaryLabel)) } }; GeometryReader { geometry in ZStack(alignment: .leading) { Capsule().fill(Color(uiColor: .systemGray5)).frame(height: 4); Capsule().fill(statusColor).frame(width: geometry.size.width * progress, height: 4) } }.frame(height: 4) }.padding(16).frame(maxWidth: .infinity).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4) } }

struct ConsultationItemRow: View { let icon: String; let iconColor: Color; let iconBgColor: Color; let title: String; let subtitle: String; var body: some View { HStack(spacing: 16) { ZStack { RoundedRectangle(cornerRadius: 12).fill(iconBgColor).frame(width: 48, height: 48); Image(systemName: icon).font(.title3).foregroundStyle(iconColor) }; VStack(alignment: .leading, spacing: 4) { Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Text(subtitle).font(.caption).foregroundStyle(Color(uiColor: .secondaryLabel)) }; Spacer() }.padding(16).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4) } }

#Preview {
    NavigationStack {
        DoctorConsultationView()
    }
}
