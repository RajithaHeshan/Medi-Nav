import SwiftUI

struct ClinicMapView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
   
    @State private var routePath: [CGPoint] = []
    @State private var currentDotPosition: CGPoint = CGPoint(x: 0.05, y: 0.52) // Default at Entrance
    @State private var isNavigating = false
    @State private var selectedDestinationName: String? = nil
    
    // Assuming the user always starts at the Main Entrance for this example
    let startingLocationID = "entrance_left"
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header & Search Bar
            VStack(spacing: 16) {
                HStack {
                    Button { dismiss() } label: { Image(systemName: "chevron.left").font(.title2).bold().foregroundStyle(.black) }
                    Spacer()
                    Text("Clinic Navigation").font(.headline).bold()
                    Spacer()
                    Image(systemName: "chevron.left").font(.title2).opacity(0)
                }
                
                // Search Bar Overlay
                HStack {
                    Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                    TextField("Search for a room or department...", text: $searchText)
                        .focused($isSearchFocused) // 🔴 FIXED: Binds the keyboard focus
                        .onSubmit {
                            // 🔴 FIXED: If user presses "Return" on keyboard, pick the best match automatically
                            if let bestMatch = searchResults.first {
                                selectDestination(node: bestMatch)
                            }
                        }
                    
                    if !searchText.isEmpty || isSearchFocused {
                        Button(action: resetSearch) {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.gray)
                        }
                    }
                }
                .padding(12)
                .background(Color(uiColor: .systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
            .background(Color(uiColor: .systemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 5, y: 5)
            .zIndex(10) // Ensures the search bar shadow stays on top
            
            ZStack(alignment: .top) {
                
                // 2. The Map Area
                VStack {
                    Spacer()
                    
                    Image("ClinicMapImage")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        .padding(.horizontal, 16)
                        .overlay(
                            GeometryReader { geometry in
                                ZStack(alignment: .topLeading) {
                                    
                                    // A. Draw the dynamic dashed route line
                                    Path { path in
                                        guard let first = routePath.first else { return }
                                        path.move(to: convert(point: first, in: geometry.size))
                                        for point in routePath.dropFirst() {
                                            path.addLine(to: convert(point: point, in: geometry.size))
                                        }
                                    }
                                    .stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 5, dash: [8, 6]))
                                    
                                    // B. The Animated Navigation Dot (Only shows if a route exists)
                                    if !routePath.isEmpty {
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 18, height: 18)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                            .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0)
                                            .position(convert(point: currentDotPosition, in: geometry.size))
                                    }
                                }
                            }
                        )
                    
                    Spacer()
                    
                    // Route Info Footer (Appears when a room is selected)
                    if let destName = selectedDestinationName {
                        VStack(spacing: 12) {
                            Text("Navigating to: \(destName)")
                                .font(.headline)
                            
                            Button(action: startNavigationAnimation) {
                                HStack {
                                    Image(systemName: isNavigating ? "figure.walk" : "play.fill")
                                    Text(isNavigating ? "Navigating..." : "Start Route")
                                }
                                .font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding()
                                .background(isNavigating ? Color.gray : Color.blue).clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .disabled(isNavigating)
                        }
                        .padding(20)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: Color.black.opacity(0.08), radius: 10, y: -5)
                    }
                }
                
                // 3. Search Results Dropdown List
                // 🔴 FIXED: Reliably shows up when typing
                if isSearchFocused && !searchText.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(searchResults, id: \.id) { node in
                                Button {
                                    selectDestination(node: node)
                                } label: {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue)
                                        Text(node.name).font(.body).foregroundStyle(Color(uiColor: .label))
                                        Spacer()
                                        Image(systemName: "chevron.right").font(.caption).foregroundStyle(.gray)
                                    }
                                    .padding()
                                    .background(Color(uiColor: .systemBackground))
                                }
                                Divider().padding(.leading, 40)
                            }
                        }
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                }
            }
        }
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .navigationBarHidden(true)
    }
    
    // MARK: - Logic & Computed Properties
    
    // Filters the searchable rooms based on what the user types
    var searchResults: [MapNode] {
        let allDestinations = ClinicMapData.shared.searchableDestinations
        if searchText.isEmpty {
            return allDestinations
        } else {
            return allDestinations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // Converts relative 0.0-1.0 coordinates to actual screen pixels
    private func convert(point: CGPoint, in size: CGSize) -> CGPoint {
        return CGPoint(x: point.x * size.width, y: point.y * size.height)
    }
    
    // Called when user taps a room in the search list OR hits return
    private func selectDestination(node: MapNode) {
        // 1. Hide keyboard
        isSearchFocused = false
        
        // 2. Set the UI states
        selectedDestinationName = node.name
        searchText = node.name
        
        // 3. MAGIC HAPPENS HERE: Calculate the path using the Engine!
        routePath = NavigationEngine.findPath(from: startingLocationID, to: node.id)
        
        // 4. Snap the dot to the starting point
        if let firstPoint = routePath.first {
            currentDotPosition = firstPoint
        }
    }
    
    // Clears everything out
    private func resetSearch() {
        withAnimation {
            searchText = ""
            isSearchFocused = false
            routePath = []
            selectedDestinationName = nil
            isNavigating = false
        }
    }
    
    // Animates the dot along the calculated path
    private func startNavigationAnimation() {
        guard !routePath.isEmpty else { return }
        isNavigating = true
        
        Task {
            for point in routePath {
                await MainActor.run {
                    withAnimation(.linear(duration: 1.0)) {
                        currentDotPosition = point
                    }
                }
                // Wait 1 second before moving to the next point
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            
            await MainActor.run {
                isNavigating = false
            }
        }
    }
}

#Preview {
    ClinicMapView()
}
