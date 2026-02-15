import SwiftUI

struct DoctorBookingView: View {
    @Environment(\.dismiss) var dismiss
    
    // Data passed from previous screen
    let doctor: Doctor
    
    // MARK: - State Variables
    // 1. CHANGED: Now using real Date objects instead of Int
    @State private var selectedDate: Date = Date()
    @State private var calendarDays: [Date] = []
    
    @State private var selectedTime: String = "10:30 AM"
    @State private var medicationText: String = ""
    
    // Mock Time Slots (Keep these for now)
    let morningSlots = ["09:00 AM", "09:30 AM", "10:30 AM", "11:00 AM", "11:30 AM"]
    let afternoonSlots = ["02:00 PM", "03:30 PM", "04:00 PM"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 2. UPDATED: Date Selection
                        dateSelectionSection
                        
                        // Time Selection
                        timeSelectionSection
                        
                        // Upload Reports
                        uploadSection(title: "Upload Previous Medical Reports")
                        
                        // Medication Input
                        medicationSection
                        
                        Spacer(minLength: 100)
                    }
                    .padding()
                }
            }
            
            // Footer
            bottomFooter
        }
        .navigationBarHidden(true)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        // 3. NEW: Generate Dates on Appear
        .onAppear {
            generateDates()
        }
    }
    
    // MARK: - Date Logic Helper
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        // Generate next 30 days
        var dates: [Date] = []
        for i in 0..<30 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
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
                Image(systemName: "chevron.left")
                    .font(.title3).bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            // Tiny Doctor Profile
            HStack(spacing: 12) {
                Image(doctor.image)
                    .resizable().scaledToFill()
                    .frame(width: 40, height: 40).clipShape(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(doctor.name).font(.subheadline).bold()
                    HStack(spacing: 4) {
                        Text(doctor.specialty).font(.caption2).foregroundStyle(.secondary)
                        Text("•").font(.caption2).foregroundStyle(.secondary)
                        Image(systemName: "star.fill").font(.caption2).foregroundStyle(.yellow)
                        Text(String(format: "%.1f", doctor.rating)).font(.caption2).foregroundStyle(.black)
                    }
                }
            }
            Spacer()
            Button { } label: {
                Image(systemName: "info.circle.fill").font(.title3).foregroundStyle(.blue)
            }
        }
        .padding().background(Color(uiColor: .systemBackground))
    }
    
    private var dateSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Select Date")
                    .font(.headline)
                Spacer()
                // 4. DYNAMIC HEADER: Updates based on selectedDate
                Text(selectedDate.formatted(.dateTime.month(.wide).year()))
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .animation(.none, value: selectedDate) // Prevent jumpy text animation
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // 5. DYNAMIC LOOP: Uses real Date objects
                    ForEach(calendarDays, id: \.self) { date in
                        let isSelected = isSameDay(date1: selectedDate, date2: date)
                        
                        VStack(spacing: 8) {
                            // Format: "Mon", "Tue"
                            Text(date.formatted(.dateTime.weekday(.abbreviated)))
                                .font(.caption)
                                .foregroundStyle(isSelected ? .white.opacity(0.8) : .secondary)
                            
                            // Format: "24", "25"
                            Text(date.formatted(.dateTime.day()))
                                .font(.title3).bold()
                                .foregroundStyle(isSelected ? .white : .primary)
                        }
                        .frame(width: 60, height: 70)
                        .background(isSelected ? Color.blue : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        // iOS-style flat border
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(uiColor: .systemGray5), lineWidth: isSelected ? 0 : 1)
                        )
                        .onTapGesture {
                            withAnimation { selectedDate = date }
                        }
                    }
                }
                .padding(.horizontal, 2)
                .padding(.bottom, 10)
            }
        }
    }
    
    private var timeSelectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Select Time")
                    .font(.headline)
                // Dynamic Subtitle: e.g. "Available slots for Tue, 24 Oct"
                Text("Available slots for \(selectedDate.formatted(.dateTime.weekday(.abbreviated))), \(selectedDate.formatted(.dateTime.day())) \(selectedDate.formatted(.dateTime.month(.abbreviated)))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text("Morning").font(.caption).fontWeight(.semibold).foregroundStyle(.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 12) {
                ForEach(morningSlots, id: \.self) { time in
                    timeSlotPill(time: time)
                }
            }
            
            Text("Afternoon").font(.caption).fontWeight(.semibold).foregroundStyle(.secondary).padding(.top, 8)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))], spacing: 12) {
                ForEach(afternoonSlots, id: \.self) { time in
                    timeSlotPill(time: time)
                }
            }
        }
    }
    
    private func timeSlotPill(time: String) -> some View {
        let isSelected = selectedTime == time
        let isDisabled = time == "11:30 AM"
        
        return Button {
            if !isDisabled { selectedTime = time }
        } label: {
            Text(time)
                .font(.caption).bold()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isDisabled ? Color(uiColor: .systemGray6) : isSelected ? Color.blue : Color.white)
                .foregroundStyle(isDisabled ? Color.gray : isSelected ? Color.white : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: (isSelected || isDisabled) ? 0 : 1)
                )
        }
        .disabled(isDisabled)
    }
    
    private func uploadSection(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.headline)
            HStack(spacing: 16) {
                // ADD Button (SF Symbol style)
                Button { } label: {
                    Image(systemName: "plus.circle.fill") // SF Symbol style
                        .font(.largeTitle) // Bigger, cleaner icon
                        .foregroundStyle(.blue)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.3), lineWidth: 1))
                }
                
                // Document Icon (SF Symbol style)
                VStack {
                    Image(systemName: "doc.fill") // SF Symbol style
                        .font(.title2).foregroundStyle(.gray)
                    Text("Blood_Te...").font(.caption2).foregroundStyle(.secondary)
                }
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    private var medicationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upload or mentioned current Medication").font(.headline)
            
            // Reusing upload style
            HStack(spacing: 16) {
                Button { } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.3), lineWidth: 1))
                }
                VStack {
                    Image(systemName: "doc.fill").font(.title2).foregroundStyle(.gray)
                    Text("Blood_Te...").font(.caption2).foregroundStyle(.secondary)
                }
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            TextEditor(text: $medicationText)
                .frame(height: 100)
                .padding(8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .overlay(
                    Group {
                        if medicationText.isEmpty {
                            Text("List your current prescriptions (e.g. Lisinopril 10mg, Metformin...)")
                                .font(.caption).foregroundStyle(.gray.opacity(0.6)).padding(.top, 16).padding(.leading, 12)
                        }
                    }, alignment: .topLeading
                )
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
            .padding(.horizontal)
            
            Button {
                print("Booking Confirmed for \(doctor.name) on \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
            } label: {
                Text("Confirm Booking")
                    .font(.headline).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(Color.blue).clipShape(Capsule())
            }
            .padding(.horizontal).padding(.bottom, 10)
        }
        .padding(.top, 10).background(Color(uiColor: .systemBackground))
        .shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
    }
}

// Preview
#Preview {
    DoctorBookingView(doctor: Doctor(
        name: "Dr. Sarah Jenkins",
        specialty: "Cardiologist",
        rating: 4.9,
        reviewCount: 120,
        fee: 150,
        image: "doctor1",
        status: "Available Today",
        statusColor: .green,
        isBookable: true
    ))
}
