
import SwiftUI


struct ConsultationRecord: Identifiable, Hashable {
    let id = UUID()
    let doctorName: String
    let specialty: String
    let date: String
    let diagnosis: String
    let image: String
    let status: String
    
   
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct DoctorConsultationHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    @State private var selectedTab = "Completed"
    @State private var selectedRecord: ConsultationRecord?
    
   
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
    
    // Filters by the selected tab AND the search text
    var filteredRecords: [ConsultationRecord] {
        let tabFiltered = historyRecords.filter { $0.status == selectedTab }
        
        if searchText.isEmpty {
            return tabFiltered
        } else {
            return tabFiltered.filter { record in
                record.doctorName.localizedCaseInsensitiveContains(searchText) ||
                record.specialty.localizedCaseInsensitiveContains(searchText) ||
                record.diagnosis.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                // 1. Search Bar with Mic and Clear functionality
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color(uiColor: .systemGray2))
                        .font(.body.weight(.medium))
                    
                    TextField("Search by name or specialty...", text: $searchText)
                    
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
                .padding(12)
                .background(Color(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 16)
                
                // 2. Tabs
                HStack(spacing: 0) {
                    tabButton(title: "Cancelled")
                    tabButton(title: "Completed")
                }
                .padding(4)
                .background(Color(uiColor: .systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                // 3. List of Cards
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        ForEach(filteredRecords) { record in
                            ConsultationHistoryCard(record: record) {
                                selectedRecord = record
                            }
                        }
                        
                       
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
        
        .navigationDestination(item: $selectedRecord) { record in
            ConsultationDetailView(
                doctorName: record.doctorName,
                specialty: record.specialty,
                date: record.date,
                image: record.image
            )
            .navigationBarBackButtonHidden(true)
        }
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
            
            Text("Consultation History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
    
    private func tabButton(title: String) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = title
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(selectedTab == title ? Color(uiColor: .systemBackground) : Color.clear)
                .foregroundStyle(selectedTab == title ? Color(uiColor: .label) : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: selectedTab == title ? Color.black.opacity(0.1) : Color.clear, radius: 2, x: 0, y: 1)
        }
    }
}

struct ConsultationHistoryCard: View {
    let record: ConsultationRecord
    var onViewSummary: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Top Row
            HStack(alignment: .top, spacing: 12) {
                Image(record.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(record.doctorName)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(record.specialty)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text(record.date)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            // Diagnosis Box
            VStack(alignment: .leading, spacing: 8) {
                Text("Primary Diagnosis")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue.opacity(0.8))
                
                Text(record.diagnosis)
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .label))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineSpacing(4)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Bottom Actions Row
            HStack(spacing: 8) {
                Button {} label: {
                    Image(systemName: "plus.app.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                
                Button {} label: {
                    Image(systemName: "doc.text.fill")
                        .font(.title2)
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .padding(8)
                        .contentShape(Rectangle())
                }
                
                Spacer()
                
                Button {
                    onViewSummary()
                } label: {
                    Text("View Summary")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue.opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        DoctorConsultationHistoryView()
    }
}
