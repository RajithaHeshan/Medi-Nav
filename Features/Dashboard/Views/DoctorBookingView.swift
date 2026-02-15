
import SwiftUI

struct DoctorBookingView: View {
    @Environment(\.dismiss) var dismiss
    let doctor: Doctor
    
    
    @State private var selectedDate: Date = Date()
    @State private var calendarDays: [Date] = []
    @State private var selectedTime: String = "10:30 AM"
    @State private var medicationText: String = ""
    
   
    @State private var showAttachmentMenu = false
    @State private var showImagePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var uploadedImages: [UIImage] = []
    @State private var tempImage: UIImage?

    
    let morningSlots = ["09:00 AM", "09:30 AM", "10:30 AM", "11:00 AM", "11:30 AM"]
    let afternoonSlots = ["02:00 PM", "03:30 PM", "04:00 PM"]
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    dateSelectionSection
                    timeSelectionSection
                    
                    
                    uploadSection(title: "Upload Previous Medical Reports")
                    
                    medicationSection
                    Spacer(minLength: 20)
                }
                .padding()
            }
            
            bottomFooter
        }
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea(edges: .bottom))
        .navigationBarHidden(true)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear { generateDates() }
        
        
        .confirmationDialog("Select Photo", isPresented: $showAttachmentMenu, titleVisibility: .visible) {
            Button("Camera") {
                self.imageSource = .camera
                self.showImagePicker = true
            }
            Button("Photo Library") {
                self.imageSource = .photoLibrary
                self.showImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose how you'd like to add a photo")
        }
       
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let newImage = tempImage {
                uploadedImages.append(newImage) // Add photo to list
                tempImage = nil
            }
        }) {
            ImagePicker(selectedImage: $tempImage, isPresented: $showImagePicker, sourceType: imageSource)
                .ignoresSafeArea()
        }
    }
    
    
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
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            HStack(spacing: 12) {
                Image(doctor.image).resizable().scaledToFill().frame(width: 40, height: 40).clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(doctor.name).font(.subheadline).bold()
                    HStack(spacing: 4) {
                        Text(doctor.specialty).font(.caption2).foregroundStyle(.secondary)
                        Image(systemName: "star.fill").font(.caption2).foregroundStyle(.yellow)
                        Text(String(format: "%.1f", doctor.rating)).font(.caption2).foregroundStyle(.black)
                    }
                }
            }
            Spacer()
            Button { } label: { Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue) }
        }.padding().background(Color(uiColor: .systemBackground))
    }
    
    private var dateSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Select Date").font(.headline)
                Spacer()
                Text(selectedDate.formatted(.dateTime.month(.wide).year())).font(.subheadline).foregroundStyle(.blue)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(calendarDays, id: \.self) { date in
                        let isSelected = isSameDay(date1: selectedDate, date2: date)
                        VStack(spacing: 8) {
                            Text(date.formatted(.dateTime.weekday(.abbreviated)))
                                .font(.caption).foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
                            Text(date.formatted(.dateTime.day()))
                                .font(.title3).bold().foregroundStyle(isSelected ? .white : .primary)
                        }
                        .frame(width: 60, height: 70)
                        .background(isSelected ? Color.blue : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(uiColor: .systemGray5), lineWidth: isSelected ? 0 : 1))
                        .onTapGesture { withAnimation { selectedDate = date } }
                    }
                }
                .padding(.horizontal, 2).padding(.bottom, 10)
            }
        }
    }
    
    private var timeSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Select Time").font(.headline)
                Text("Available slots for \(selectedDate.formatted(.dateTime.weekday(.abbreviated)))").font(.caption).foregroundStyle(.secondary)
            }
            Text("Morning").font(.caption).fontWeight(.semibold).foregroundStyle(.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 12) {
                ForEach(morningSlots, id: \.self) { time in timeSlotPill(time: time) }
            }
            Text("Afternoon").font(.caption).fontWeight(.semibold).foregroundStyle(.secondary).padding(.top, 8)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 12) {
                ForEach(afternoonSlots, id: \.self) { time in timeSlotPill(time: time) }
            }
        }
    }
    
    private func timeSlotPill(time: String) -> some View {
        let isSelected = selectedTime == time
        let isDisabled = time == "11:30 AM"
        return Button { if !isDisabled { selectedTime = time } } label: {
            Text(time).font(.caption).bold().frame(maxWidth: .infinity).padding(.vertical, 12)
                .background(isDisabled ? Color(uiColor: .systemGray6) : isSelected ? Color.blue : Color.white)
                .foregroundStyle(isDisabled ? Color.gray : isSelected ? Color.white : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: (isSelected || isDisabled) ? 0 : 1))
        }.disabled(isDisabled)
    }
    
   
    private func uploadSection(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.headline)
            
            HStack(spacing: 16) {
                
                Button {
                    showAttachmentMenu = true // Trigger the Menu
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle).foregroundStyle(.blue).frame(width: 60, height: 60)
                        .background(Color.white).clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.3), lineWidth: 1))
                }
                
                
                VStack {
                    Image(systemName: "doc.fill").font(.title2).foregroundStyle(.gray)
                    Text("Blood_Te...").font(.caption2).foregroundStyle(.secondary)
                }
                .frame(width: 60, height: 60).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 16))
                
               
                ForEach(uploadedImages, id: \.self) { img in
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                }
            }
        }
    }
    
    private var medicationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upload or mentioned current Medication").font(.headline)
           
            HStack(spacing: 16) {
                Button { showAttachmentMenu = true } label: {
                    Image(systemName: "plus.circle.fill").font(.largeTitle).foregroundStyle(.blue).frame(width: 60, height: 60).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.3), lineWidth: 1))
                }
            }
            TextEditor(text: $medicationText).frame(height: 100).padding(8).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12)).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .overlay(Group { if medicationText.isEmpty { Text("List your current prescriptions...").font(.caption).foregroundStyle(.gray.opacity(0.6)).padding(.top, 16).padding(.leading, 12) } }, alignment: .topLeading)
        }
    }
    
    private var bottomFooter: some View {
        VStack(spacing: 16) {
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Consultation Fee").font(.caption).foregroundStyle(.secondary)
                    Text("$\(doctor.fee).00").font(.title2).bold()
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Duration").font(.caption).foregroundStyle(.secondary)
                    Text("30 Mins").font(.subheadline).bold()
                }
            }
            Button { print("Booking Confirmed") } label: {
                Text("Confirm Booking").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(Capsule())
            }.padding(.bottom, 10)
        }
        .padding(.horizontal).padding(.top, 16)
        .background(Color(uiColor: .systemBackground).ignoresSafeArea(edges: .bottom))
        .shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
    }
}

#Preview {
    DoctorBookingView(doctor: Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "doctor1", status: "Available Today", statusColor: .green, isBookable: true))
    CustomTabBar(selectedTab: .constant(.home))
    CustomTabBar(selectedTab: .constant(.home))
}
