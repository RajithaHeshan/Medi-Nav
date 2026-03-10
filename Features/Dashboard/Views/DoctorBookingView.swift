
import SwiftUI

struct DoctorBookingView: View {
    @Environment(\.dismiss) var dismiss
    
    let doctor: Doctor
    
    @State private var selectedDate: Date = Date()
    @State private var calendarDays: [Date] = []
    @State private var selectedTime: String = "10:30 AM"
    @State private var medicationText: String = ""
    
    @State private var showPayment = false
    
    @State private var showAttachmentMenu = false
    @State private var showImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var uploadedImages: [UIImage] = []
    @State private var tempImage: UIImage?

    let morningSlots = ["09:00 AM", "09:30 AM", "10:30 AM", "11:00 AM", "11:30 AM"]
    let afternoonSlots = ["02:00 PM", "03:30 PM", "04:00 PM"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
              
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        // Date & Time
                        dateSelectionSection
                        timeSelectionSection
                        
                        // Uploads
                        uploadSection(title: "Previous Medical Reports")
                        medicationSection
                        
                       //Massive spacer so the user can completely scroll past the sticky footer
                        Spacer(minLength: 240)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            
            // 2. Fixed Sticky Footer (Pushed above Tab Bar)
            bottomFooter
        }
        .navigationBarHidden(true)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear { generateDates() }
        
        .confirmationDialog("Select Photo", isPresented: $showAttachmentMenu, titleVisibility: .visible) {
            Button("Camera") { self.imageSource = .camera; self.showImagePicker = true }
            Button("Photo Library") { self.imageSource = .photoLibrary; self.showImagePicker = true }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let newImage = tempImage { uploadedImages.append(newImage); tempImage = nil }
        }) {
            ImagePicker(selectedImage: $tempImage, isPresented: $showImagePicker, sourceType: imageSource)
                .ignoresSafeArea()
        }
        
        // Navigation to Payment
        .navigationDestination(isPresented: $showPayment) {
            PaymentView(
                doctor: doctor,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                flowType: .doctorBooking
            )
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Logic
    
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        var dates: [Date] = []
        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) { dates.append(date) }
        }
        self.calendarDays = dates
        self.selectedDate = dates.first ?? Date()
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    // MARK: - Subviews
    
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
            
            HStack(spacing: 12) {
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(doctor.name).font(.headline).bold()
                    HStack(spacing: 4) {
                        Text(doctor.specialty).font(.caption).foregroundStyle(.secondary)
                        Image(systemName: "star.fill").font(.caption2).foregroundStyle(.yellow)
                        Text(String(format: "%.1f", doctor.rating)).font(.caption).fontWeight(.semibold)
                    }
                }
            }
            
            Spacer()
            
            Button { } label: {
                Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var dateSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Select Date").font(.title3).fontWeight(.bold)
                Spacer()
                Text(selectedDate.formatted(.dateTime.month(.wide).year())).font(.subheadline).fontWeight(.semibold).foregroundStyle(.blue)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(calendarDays, id: \.self) { date in
                        let isSelected = isSameDay(date1: selectedDate, date2: date)
                        VStack(spacing: 8) {
                            Text(date.formatted(.dateTime.weekday(.abbreviated)))
                                .font(.caption).fontWeight(.medium).foregroundStyle(isSelected ? .white.opacity(0.9) : .secondary)
                            Text(date.formatted(.dateTime.day()))
                                .font(.title2).bold().foregroundStyle(isSelected ? .white : .primary)
                        }
                        .frame(width: 64, height: 80)
                        .background(isSelected ? Color.blue : Color(uiColor: .systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: isSelected ? Color.blue.opacity(0.3) : Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
                        .onTapGesture { withAnimation(.spring()) { selectedDate = date } }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
            }
            .padding(.horizontal, -20)
            .padding(.leading, 20)
        }
    }
    
    private var timeSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Select Time").font(.title3).fontWeight(.bold)
                Text("Available slots for \(selectedDate.formatted(.dateTime.weekday(.wide)))").font(.subheadline).foregroundStyle(.secondary)
            }
            
            Text("Morning").font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary).padding(.top, 4)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(morningSlots, id: \.self) { time in timeSlotPill(time: time) }
            }
            
            Text("Afternoon").font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary).padding(.top, 8)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                ForEach(afternoonSlots, id: \.self) { time in timeSlotPill(time: time) }
            }
        }
    }
    
    private func timeSlotPill(time: String) -> some View {
        let isSelected = selectedTime == time
        let isDisabled = time == "11:30 AM" // Example disabled logic
        
        return Button { if !isDisabled { withAnimation(.spring()) { selectedTime = time } } } label: {
            Text(time)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isDisabled ? Color(uiColor: .systemGray6) : isSelected ? Color.blue : Color(uiColor: .systemBackground))
                .foregroundStyle(isDisabled ? Color(uiColor: .systemGray3) : isSelected ? Color.white : Color(uiColor: .label))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .shadow(color: isSelected ? Color.blue.opacity(0.3) : Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        }
        .disabled(isDisabled)
    }
    
    private func uploadSection(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.headline).fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Button { showAttachmentMenu = true } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "icloud.and.arrow.up")
                                .font(.title2)
                            Text("Upload")
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(.blue)
                        .frame(width: 80, height: 80)
                        .background(Color.blue.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                .foregroundStyle(Color.blue.opacity(0.5))
                        )
                    }
                    
                    ForEach(uploadedImages, id: \.self) { img in
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    private var medicationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Medications").font(.headline).fontWeight(.bold)
            
            TextEditor(text: $medicationText)
                .frame(height: 120)
                .padding(12)
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
                .overlay(
                    Group {
                        if medicationText.isEmpty {
                            Text("List any current prescriptions or tap to type...")
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .placeholderText))
                                .padding(.top, 20)
                                .padding(.leading, 16)
                        }
                    },
                    alignment: .topLeading
                )
        }
    }
    
    private var bottomFooter: some View {
        VStack(spacing: 16) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Fee").font(.subheadline).foregroundStyle(.secondary)
                    Text("$\(doctor.fee).00").font(.title2).fontWeight(.heavy)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Duration").font(.subheadline).foregroundStyle(.secondary)
                    Text("30 Mins").font(.headline).fontWeight(.bold)
                }
            }
            
            Button {
                showPayment = true
            } label: {
                Text("Confirm Booking")
                    .font(.headline).fontWeight(.bold).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(Color.blue).clipShape(Capsule())
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 90)
        .background(
            Color(uiColor: .systemBackground)
                .shadow(color: Color.black.opacity(0.06), radius: 15, x: 0, y: -5)
        )
    }
}

#Preview {
    NavigationStack {
        DoctorBookingView(doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "Image (2)", status: "Available Today", statusColor: .green, isBookable: true))
    }
}
