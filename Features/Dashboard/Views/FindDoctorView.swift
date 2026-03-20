

import SwiftUI

struct Doctor: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let reviewCount: Int
    let fee: Int
    let image: String
    let status: String
    let statusColor: Color
    let isBookable: Bool
}

struct FindDoctorView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    @State private var selectedCategory: String
    @State private var selectedDoctor: Doctor?
    
    // Voice State
    @State private var isListening = false
    
    private let categories = ["All", "Cardiology", "Dentist", "Neurology"]
    
    init(initialSpecialty: String = "All") {
        _selectedCategory = State(initialValue: initialSpecialty)
    }
    
    private let doctors = [
        Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "doctor1", status: "Available Today", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. Mike Ross", specialty: "Neurologist", rating: 4.8, reviewCount: 98, fee: 180, image: "doctor2", status: "Available Today", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. Emily Clark", specialty: "Dentist", rating: 4.7, reviewCount: 65, fee: 120, image: "Image (2)", status: "Available Today", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. John Doe", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "Image (3)", status: "Next: Tue", statusColor: .gray, isBookable: false)
    ]
    
    var filteredDoctors: [Doctor] {
        var result = doctors
        if selectedCategory != "All" {
            if selectedCategory == "Cardiology" {
                result = result.filter { $0.specialty == "Cardiologist" }
            } else if selectedCategory == "Neurology" {
                result = result.filter { $0.specialty == "Neurologist" }
            } else {
                result = result.filter { $0.specialty == selectedCategory }
            }
        }
        if !searchText.isEmpty {
            result = result.filter { doctor in
                doctor.name.localizedCaseInsensitiveContains(searchText) ||
                doctor.specialty.localizedCaseInsensitiveContains(searchText)
            }
        }
        return result
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
             
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(uiColor: .systemGray2))
                        .font(.body.weight(.medium))
                    
                    TextField("Search doctors...", text: $searchText)
                    
                    Spacer()
                    
                    if !searchText.isEmpty {
                        Button(action: { withAnimation { searchText = "" } }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color(uiColor: .systemGray3))
                        }
                    } else {
                     
                        Button(action: { withAnimation { isListening = true } }) {
                            Image(systemName: "mic.fill")
                                .foregroundStyle(Color.blue)
                        }
                    }
                }
                .padding(10)
                .background(Color(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(filteredDoctors) { doctor in
                            DoctorRowItem(doctor: doctor) {
                                if doctor.isBookable { selectedDoctor = doctor }
                            }
                            Divider().padding(.leading, 76)
                        }
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            //  Voice Animation Overlay
            if isListening {
                voiceAnimationOverlay
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(item: $selectedDoctor) { doctor in
            DoctorBookingView(doctor: doctor)
        }
    }
    
    // MARK: - Voice Animation View
    private var voiceAnimationOverlay: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Listening...")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                HStack(spacing: 4) {
                    ForEach(0..<8) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: 4, height: isListening ? CGFloat.random(in: 10...60) : 10)
                            .animation(.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: isListening)
                    }
                }
                
                Button {
                    isListening = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }
            .padding(40)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .transition(.opacity)
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
            Text("Find a Doctor")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

// Keeping your original DoctorRowItem
struct DoctorRowItem: View {
    let doctor: Doctor
    var onBook: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemGray6))
                    .frame(width: 64, height: 64)
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name).font(.headline).foregroundStyle(Color(uiColor: .label))
                Text(doctor.specialty).font(.subheadline).foregroundStyle(.secondary)
                HStack(spacing: 4) {
                    Image(systemName: "circle.fill").font(.system(size: 8)).foregroundStyle(doctor.statusColor)
                    Text(doctor.status).font(.caption).foregroundStyle(doctor.statusColor).fontWeight(.medium)
                    Text("• $\(doctor.fee)").font(.caption).foregroundStyle(.secondary)
                }
            }
            Spacer()
            Button(action: onBook) {
                Text(doctor.isBookable ? "Book" : "Wait")
                    .font(.subheadline).fontWeight(.bold)
                    .padding(.horizontal, 20).padding(.vertical, 10)
                    .background(doctor.isBookable ? Color.blue : Color(uiColor: .systemGray5))
                    .foregroundStyle(doctor.isBookable ? .white : Color(uiColor: .systemGray))
                    .clipShape(Capsule())
            }
        }
        .padding(.vertical, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
       
        FindDoctorView(initialSpecialty: "Dentist")
    }
}
