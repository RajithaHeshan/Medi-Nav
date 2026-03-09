
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
    @State private var selectedCategory = "All"
    @State private var selectedDoctor: Doctor?
    
    private let categories = ["All", "Cardiology", "Dentist", "Neurology"]
    
    private let doctors = [
        Doctor(
            name: "Dr. Sarah Jenkins",
            specialty: "Cardiologist",
            rating: 4.9,
            reviewCount: 120,
            fee: 150,
            image: "doctor1", // Replace with your actual asset name
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. Mike Ross",
            specialty: "Neurologist",
            rating: 4.8,
            reviewCount: 98,
            fee: 180,
            image: "doctor2", // Replace with your actual asset name
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. Emily Clark",
            specialty: "Dentist",
            rating: 4.7,
            reviewCount: 65,
            fee: 120,
            image: "Image (2)",
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. John Doe",
            specialty: "Cardiologist",
            rating: 4.9,
            reviewCount: 120,
            fee: 150,
            image: "Image (3)",
            status: "Next: Tue",
            statusColor: .gray,
            isBookable: false
        )
    ]
    
    // MARK: - Smart Filter Logic (Now supports the Search Bar too!)
    var filteredDoctors: [Doctor] {
        var result = doctors
        
        // 1. Filter by Category
        if selectedCategory != "All" {
            if selectedCategory == "Cardiology" {
                result = result.filter { $0.specialty == "Cardiologist" }
            } else if selectedCategory == "Neurology" {
                result = result.filter { $0.specialty == "Neurologist" }
            } else {
                result = result.filter { $0.specialty == selectedCategory }
            }
        }
        
        // 2. Filter by Search Text
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
                                .offset(x: -1.5) // Visually centers the Apple SF Symbol perfectly
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
                
                // 2. HIG Compliant Search Bar with Dynamic Microphone/Xmark
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(uiColor: .systemGray2))
                        .font(.body.weight(.medium))
                    
                    TextField("Search doctors...", text: $searchText)
                    
                    Spacer()
                    
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            withAnimation { searchText = "" }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color(uiColor: .systemGray3))
                                .font(.body.weight(.medium))
                        }
                    } else {
                        Image(systemName: "mic.fill")
                            .foregroundStyle(Color(uiColor: .systemGray2))
                            .font(.body.weight(.medium))
                    }
                }
                .padding(10)
                .background(Color(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
                // 3. Category Picker
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                
                // 4. Scrollable List
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(filteredDoctors) { doctor in
                            DoctorRowItem(doctor: doctor) {
                                if doctor.isBookable {
                                    selectedDoctor = doctor
                                }
                            }
                            
                            
                            Divider().padding(.leading, 76)
                        }
                        
                        // Keeps content above the CustomTabBar
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarHidden(true) // Kills the double Apple back button entirely!
        .navigationDestination(item: $selectedDoctor) { doctor in
            DoctorBookingView(doctor: doctor)
        }
    }
}

// MARK: - Reusable Row Component
struct DoctorRowItem: View {
    let doctor: Doctor
    var onBook: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // Profile Image
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemGray6))
                    .frame(width: 60, height: 60)
                
                Image(doctor.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(doctor.specialty)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(doctor.statusColor)
                    
                    Text(doctor.status)
                        .font(.caption)
                        .foregroundStyle(doctor.statusColor)
                        .fontWeight(.medium)
                    
                    Text("• $\(doctor.fee)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            // Action Button
            Button(action: onBook) {
                Text(doctor.isBookable ? "Book" : "Wait")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
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
        FindDoctorView()
    }
}
