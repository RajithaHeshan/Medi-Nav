import SwiftUI

// Local Data Model
struct ConsultationRecord: Identifiable {
    let id = UUID()
    let doctorName: String
    let specialty: String
    let date: String
    let diagnosis: String
    let image: String
    let status: String
}

struct DoctorConsultationHistoryView: View {
    // No need for @Environment(\.dismiss) anymore, system handles it!
    
    // MARK: - State
    @State private var searchText = ""
    @State private var selectedTab = "Completed"
    
    // MARK: - Mock Data
    private let historyRecords = [
        ConsultationRecord(
            doctorName: "Dr. Sarah Jenkins",
            specialty: "Cardiologist",
            date: "24 Oct 2023",
            diagnosis: "Mild hypertension with prescribed lifestyle adjustments.",
            image: "doctor1",
            status: "Completed"
        ),
        ConsultationRecord(
            doctorName: "Dr. Sarah Jenkins",
            specialty: "Cardiologist",
            date: "10 Sep 2023",
            diagnosis: "Regular checkup. BP levels stable. Continue current medication.",
            image: "doctor1",
            status: "Completed"
        ),
        ConsultationRecord(
            doctorName: "Dr. Mike Ross",
            specialty: "Neurologist",
            date: "05 Aug 2023",
            diagnosis: "Migraine consultation. Prescribed Sumatriptan.",
            image: "doctor2",
            status: "Completed"
        )
    ]
    
    var filteredRecords: [ConsultationRecord] {
        return historyRecords.filter { $0.status == selectedTab }
    }
    
    var body: some View {
        // NOTE: In the parent view, ensure this is wrapped in NavigationStack
        // If this is a destination, we just use the content here.
        VStack(spacing: 0) {
            
            // 1. Search Bar (Native Header removed)
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search by name or specialty...", text: $searchText)
            }
            .padding(12)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.top, 10) // Small top padding since header is gone
            .padding(.bottom, 16)
            
            // 2. Custom Segmented Control
            HStack(spacing: 0) {
                tabButton(title: "Cancelled")
                tabButton(title: "Completed")
            }
            .padding(4)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            // 3. List of Cards
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) { // Increased spacing between cards
                    ForEach(filteredRecords) { record in
                        ConsultationHistoryCard(record: record)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        // 🔴 NATIVE NAVIGATION
        .navigationTitle("Consultation History")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Subviews
    
    private func tabButton(title: String) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = title
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedTab == title ? Color.white : Color.clear)
                .foregroundStyle(selectedTab == title ? Color.black : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: selectedTab == title ? Color.black.opacity(0.1) : Color.clear, radius: 2, x: 0, y: 1)
        }
    }
}

// MARK: - Polished History Card
struct ConsultationHistoryCard: View {
    let record: ConsultationRecord
    
    var body: some View {
        // 🟢 Increased internal spacing to 20
        VStack(alignment: .leading, spacing: 20) {
            
            // Top Row
            HStack(alignment: .top, spacing: 12) {
                Image(record.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(record.doctorName)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(record.specialty)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text(record.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // 🟢 FLATTENED Diagnosis Box
            VStack(alignment: .leading, spacing: 8) {
                Text("Primary Diagnosis")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue.opacity(0.8))
                
                Text(record.diagnosis)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .label))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(4) // Better readability
            }
            .padding(16) // Generous internal padding
            .frame(maxWidth: .infinity, alignment: .leading)
            // Lighter, flatter background
            .background(Color.gray.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Bottom Actions Row
            HStack {
                Button {} label: {
                    Image(systemName: "plus.app.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                
                Button {} label: {
                    Image(systemName: "doc.text.fill")
                        .font(.title2)
                        .foregroundStyle(Color(uiColor: .systemGray4))
                }
                
                Spacer()
                
                Button {} label: {
                    Text("View Summary")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10) // Slightly taller button
                        .background(Color.blue.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        // 🟢 Increased Card Padding to 20
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Softer corners
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4) // Softer shadow
    }
}

#Preview {
    NavigationStack {
        DoctorConsultationHistoryView()
    }
}
