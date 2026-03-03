import SwiftUI

struct LabReportHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var selectedReport: HistoryReportItem?
    
    // Filters (Long names work perfectly here!)
    let filters = ["All", "Blood", "Urine", "Pathology", "Radiology", "Microbiology"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Header
                headerView
                
                // 2. Search & Filters
                VStack(spacing: 16) {
                    searchBar
                    
                   
                    filterBar
                }
                .padding(.bottom, 16)
                .background(Color(uiColor: .systemBackground))
                
               
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // Section: October 2023
                        historySection(header: "October 2023") {
                            if showItem(type: "Blood") {
                                HistoryReportRow(
                                    title: "Lipid Profile",
                                    date: "Oct 24",
                                    doctor: "Dr. Sarah Johnson",
                                    icon: "drop.fill",
                                    iconColor: .red,
                                    resultBadge: "High Risk",
                                    badgeColor: .red
                                ) {
                                    selectedReport = HistoryReportItem(title: "Lipid Profile", status: .ready)
                                }
                            }
                            
                            if showItem(type: "Blood") {
                               
                                Divider().padding(.leading, 72)
                                
                                HistoryReportRow(
                                    title: "Complete Blood Count",
                                    date: "Oct 12",
                                    doctor: "Dr. Smith",
                                    icon: "drop.fill",
                                    iconColor: .purple,
                                    resultBadge: "Normal",
                                    badgeColor: .green
                                ) {
                                    selectedReport = HistoryReportItem(title: "Complete Blood Count", status: .ready)
                                }
                            }
                        }
                        
                        // Section: September 2023
                        historySection(header: "September 2023") {
                            if showItem(type: "Urine") {
                                HistoryReportRow(
                                    title: "Urinalysis",
                                    date: "Sep 10",
                                    doctor: "Dr. Sarah Johnson",
                                    icon: "flask.fill",
                                    iconColor: .yellow,
                                    resultBadge: "Normal",
                                    badgeColor: .green
                                ) {
                                    selectedReport = HistoryReportItem(title: "Urinalysis", status: .archived)
                                }
                            }
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // MARK: - Destination
            .navigationDestination(item: $selectedReport) { report in
                LabReportDetailView(
                    reportTitle: report.title,
                    status: report.status
                )
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Data Model
    struct HistoryReportItem: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let status: LabStatus
    }
    
    // Filter Logic
    private func showItem(type: String) -> Bool {
        return selectedFilter == "All" || selectedFilter == type
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            Text("Lab History").font(.headline).bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.gray)
            TextField("Search past reports...", text: $searchText)
        }
        .padding(12)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
    
    // 🟢 UPDATED FILTER BAR (Matches VitalHistoryView style)
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    Button {
                        withAnimation(.snappy) {
                            selectedFilter = filter
                        }
                    } label: {
                        Text(filter)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedFilter == filter ? Color.blue : Color(uiColor: .secondarySystemBackground))
                            .foregroundStyle(selectedFilter == filter ? .white : .primary)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func historySection<Content: View>(header: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.leading, 16)
            
            VStack(spacing: 0) {
                content()
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - History Row Component
struct HistoryReportRow: View {
    let title: String
    let date: String
    let doctor: String
    let icon: String
    let iconColor: Color
    let resultBadge: String
    let badgeColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon Box
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.body)
                        .foregroundStyle(iconColor)
                }
                
                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("\(date) • \(doctor)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Result Badge
                Text(resultBadge)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(badgeColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(badgeColor.opacity(0.1))
                    .clipShape(Capsule())
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.gray.opacity(0.4))
            }
            .padding(16)
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LabReportHistoryView()
}
