import SwiftUI

struct LabReportHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var selectedReport: HistoryReportItem?
    
  
    let filters = ["All", "Blood", "Urine", "Pathology", "Radiology", "Microbiology"]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                   
                    VStack(spacing: 16) {
                        headerView
                        searchBar
                        filterBar
                    }
                    .padding(.bottom, 16)
                    .background(Color(uiColor: .systemBackground))
                  
                    .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 4)
                    .zIndex(1)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                        
                            historySection(header: "October 2023") {
                                if showItem(type: "Blood", title: "Lipid Profile") {
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
                                
                               
                                if showItem(type: "Blood", title: "Lipid Profile") && showItem(type: "Blood", title: "Complete Blood Count") {
                                    Divider().padding(.leading, 72)
                                }
                                
                                if showItem(type: "Blood", title: "Complete Blood Count") {
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
                            
                          
                            historySection(header: "September 2023") {
                                if showItem(type: "Urine", title: "Urinalysis") {
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
                            
                          
                            Spacer(minLength: 120)
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            
          
            .navigationDestination(item: $selectedReport) { report in
              
                Text("Detail View for: \(report.title)")
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
  
    struct HistoryReportItem: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let status: LabStatus
    }
    
   
    enum LabStatus {
        case ready, pending, archived
    }
    
   
    private func showItem(type: String, title: String) -> Bool {
        let matchesFilter = selectedFilter == "All" || selectedFilter == type
        let matchesSearch = searchText.isEmpty || title.localizedCaseInsensitiveContains(searchText)
        return matchesFilter && matchesSearch
    }
    
   
    private var headerView: some View {
        HStack(spacing: 16) {
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemGroupedBackground)) // Slightly darker to pop against the white header
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.blue)
                        .offset(x: -1.5)
                }
            }
            
            Spacer()
            
            Text("Lab History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40) // Visually centers the text
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
   
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
            
            TextField("Search past reports...", text: $searchText)
            
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
        .background(Color(uiColor: .systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
    }
    
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
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(selectedFilter == filter ? Color.blue : Color(uiColor: .systemGroupedBackground))
                            .foregroundStyle(selectedFilter == filter ? .white : Color(uiColor: .label))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, 20)
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
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20)) 
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
        }
    }
}


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
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundStyle(iconColor)
                }
                
              
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("\(date) • \(doctor)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
               
                Text(resultBadge)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(badgeColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(badgeColor.opacity(0.1))
                    .clipShape(Capsule())
                
               
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemGray3))
            }
            .padding(16)
            .background(Color(uiColor: .systemBackground))
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LabReportHistoryView()
}
