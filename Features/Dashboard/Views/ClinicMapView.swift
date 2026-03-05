
import SwiftUI

struct ClinicMapView: View {
    @Environment(\.dismiss) var dismiss
    
    // Search State
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    // Navigation State
    @State private var routePath: [CGPoint] = []
    @State private var currentDotPosition: CGPoint = CGPoint(x: 0.05, y: 0.52)
    @State private var isNavigating = false
    @State private var selectedDestinationName: String? = nil
    
    // Map Tapping & Details State
    @State private var tappedNode: MapNode? = nil
    @State private var showDetailsSheet = false
    @State private var pulseAnimation = false
    
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
                
                // 🔴 UPDATED: Search Bar with HIG-compliant Microphone
                HStack {
                    Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                    
                    TextField("Search for a room or department...", text: $searchText)
                        .focused($isSearchFocused)
                        .onSubmit {
                            if let bestMatch = searchResults.first { selectDestination(node: bestMatch) }
                        }
                    
                    // HIG Behavior: Show 'X' if typing, show 'Mic' if empty
                    if !searchText.isEmpty {
                        Button(action: resetSearch) {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.gray)
                        }
                    } else {
                        Button {
                            // Action to trigger voice dictation would go here
                            print("Microphone tapped")
                        } label: {
                            Image(systemName: "mic.fill").foregroundStyle(.gray)
                        }
                    }
                }
                .padding(12).background(Color(uiColor: .systemGray6)).clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding().background(Color(uiColor: .systemBackground)).shadow(color: Color.black.opacity(0.05), radius: 5, y: 5).zIndex(10)
            
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
                                    
                                    // Invisible tappable layer covering the whole map
                                    Color.black.opacity(0.001)
                                        .onTapGesture { location in handleMapTap(at: location, in: geometry.size) }
                                    
                                    // A. Draw the dashed route line
                                    Path { path in
                                        guard let first = routePath.first else { return }
                                        path.move(to: convert(point: first, in: geometry.size))
                                        for point in routePath.dropFirst() {
                                            path.addLine(to: convert(point: point, in: geometry.size))
                                        }
                                    }
                                    .stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 5, dash: [8, 6]))
                                    
                                    // B. The Animated Navigation Dot
                                    if !routePath.isEmpty {
                                        Circle()
                                            .fill(Color.blue).frame(width: 18, height: 18)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                            .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0)
                                            .position(convert(point: currentDotPosition, in: geometry.size))
                                    }
                                    
                                    // C. The Tapped Location Pin
                                    if let tapped = tappedNode {
                                        ZStack {
                                            Circle()
                                                .fill(Color.red.opacity(0.3)).frame(width: 50, height: 50)
                                                .scaleEffect(pulseAnimation ? 1.2 : 0.8)
                                                .opacity(pulseAnimation ? 0 : 1)
                                            
                                            Circle()
                                                .fill(Color.red).frame(width: 16, height: 16)
                                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                        }
                                        .position(convert(point: tapped.position, in: geometry.size))
                                        .onAppear {
                                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) { pulseAnimation = true }
                                        }
                                    }
                                }
                            }
                        )
                    Spacer()
                }
                
                // 3. Search Results Dropdown List
                if isSearchFocused && !searchText.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(searchResults, id: \.id) { node in
                                Button { selectDestination(node: node) } label: {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue)
                                        Text(node.name).font(.body).foregroundStyle(Color(uiColor: .label))
                                        Spacer()
                                        Image(systemName: "chevron.right").font(.caption).foregroundStyle(.gray)
                                    }.padding().background(Color(uiColor: .systemBackground))
                                }
                                Divider().padding(.leading, 40)
                            }
                        }
                        .background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 12)).shadow(color: Color.black.opacity(0.1), radius: 10, y: 5).padding(.horizontal).padding(.top, 8)
                    }
                }
                
                // 4. Unified Bottom Action Area
                VStack {
                    Spacer()
                    
                    if let tapped = tappedNode {
                        // Action A: Location Details Card
                        LocationPopupCard(node: tapped) {
                            showDetailsSheet = true
                        } onClose: {
                            withAnimation { tappedNode = nil; pulseAnimation = false }
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                    } else if let destName = selectedDestinationName {
                        // Action B: Start Route Footer
                        VStack(spacing: 12) {
                            Text("Navigating to: \(destName)").font(.headline)
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
                        .padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: Color.black.opacity(0.08), radius: 10, y: -5)
                        .padding(.horizontal, 16).padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                    } else {
                        // Action C: 🔴 UPDATED: Concisely named Google Maps button
                        Button {
                            if let url = URL(string: "https://www.google.com/maps/dir//Mega+Channel+Center,+Ruwanwella/@6.209918,79.6494733,8.86z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3ae30637e030ab43:0xbb0a357b62a655a0!2m2!1d80.2546875!2d7.0434375?entry=ttu&g_ep=EgoyMDI2MDMwMi4wIKXMDSoASAFQAw%3D%3D") {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "map.fill")
                                    .font(.title3)
                                Text("Mega Clinic Location")
                                    .fontWeight(.medium)
                            }
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, y: 5)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .zIndex(5)
            }
        }
        .background(Color(uiColor: .systemGroupedBackground).ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $showDetailsSheet) {
            if let node = tappedNode { RoomDetailsView(node: node) }
        }
    }
    
    // MARK: - Logic & Computed Properties
    
    var searchResults: [MapNode] {
        let allDestinations = ClinicMapData.shared.searchableDestinations
        if searchText.isEmpty { return allDestinations } else { return allDestinations.filter { $0.name.localizedCaseInsensitiveContains(searchText) } }
    }
    
    private func convert(point: CGPoint, in size: CGSize) -> CGPoint {
        return CGPoint(x: point.x * size.width, y: point.y * size.height)
    }
    
    private func selectDestination(node: MapNode) {
        isSearchFocused = false
        selectedDestinationName = node.name
        searchText = node.name
        tappedNode = nil
        withAnimation {
            routePath = NavigationEngine.findPath(from: startingLocationID, to: node.id)
            if let firstPoint = routePath.first { currentDotPosition = firstPoint }
        }
    }
    
    private func resetSearch() {
        withAnimation {
            searchText = ""; isSearchFocused = false; routePath = []; selectedDestinationName = nil; isNavigating = false; tappedNode = nil
        }
    }
    
    private func handleMapTap(at location: CGPoint, in size: CGSize) {
        let relativeTap = CGPoint(x: location.x / size.width, y: location.y / size.height)
        var closestNode: MapNode? = nil
        var minDistance: CGFloat = 0.05
        
        for node in ClinicMapData.shared.searchableDestinations {
            let dx = relativeTap.x - node.position.x
            let dy = relativeTap.y - node.position.y
            let distance = sqrt(dx*dx + dy*dy)
            
            if distance < minDistance {
                minDistance = distance
                closestNode = node
            }
        }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            routePath = []
            selectedDestinationName = nil
            searchText = ""
            tappedNode = closestNode
            pulseAnimation = false
        }
    }
    
    private func startNavigationAnimation() {
        guard !routePath.isEmpty else { return }
        isNavigating = true
        Task {
            for point in routePath {
                await MainActor.run { withAnimation(.linear(duration: 1.0)) { currentDotPosition = point } }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            await MainActor.run { isNavigating = false }
        }
    }
}

// MARK: - Custom UI Components

struct LocationPopupCard: View {
    let node: MapNode
    let onDetailsTapped: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Capsule().fill(Color.gray.opacity(0.3)).frame(width: 40, height: 4)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(node.name).font(.title2).fontWeight(.bold)
                    HStack(spacing: 6) {
                        Image(systemName: "building.2").foregroundStyle(.gray)
                        Text("Ground Floor").foregroundStyle(.secondary)
                    }.font(.subheadline)
                }
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark").font(.system(size: 14, weight: .bold)).foregroundStyle(.gray).padding(8).background(Color(uiColor: .systemGray6)).clipShape(Circle())
                }
            }
            
            Button(action: onDetailsTapped) {
                Text("Details").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24)).shadow(color: Color.black.opacity(0.15), radius: 20, y: 10).padding(.horizontal, 16).padding(.bottom, 20)
    }
}

struct RoomDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let node: MapNode
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(node.name).font(.largeTitle).fontWeight(.bold)
                        HStack {
                            Image(systemName: "building.2").foregroundStyle(.gray)
                            Text("Ground Floor").foregroundStyle(.secondary)
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Room Information").font(.headline).fontWeight(.bold)
                        DetailRow(icon: "number", title: "Room ID", value: "RM-\(node.id.suffix(4).uppercased())")
                        DetailRow(icon: "building.2", title: "Floor", value: "Ground Floor")
                        DetailRow(icon: "location", title: "Position", value: "(\(String(format: "%.2f", node.position.x)), \(String(format: "%.2f", node.position.y)))")
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "magnifyingglass").foregroundStyle(.gray)
                                Text("Search Terms").font(.subheadline).fontWeight(.medium)
                            }
                            HStack {
                                SearchTag(text: node.name.lowercased())
                                SearchTag(text: "clinic")
                                SearchTag(text: "room")
                            }
                        }
                    }
                }
                .padding(24)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }.fontWeight(.semibold).padding(.horizontal, 12).padding(.vertical, 6).background(Color(uiColor: .systemGray6)).clipShape(Capsule())
                }
            }
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    var body: some View {
        HStack { Image(systemName: icon).frame(width: 24).foregroundStyle(.gray); Text(title).fontWeight(.medium); Spacer(); Text(value).foregroundStyle(.secondary) }.font(.subheadline)
    }
}

struct SearchTag: View {
    let text: String
    var body: some View { Text(text).font(.caption).foregroundStyle(.blue).padding(.horizontal, 12).padding(.vertical, 6).background(Color.blue.opacity(0.1)).clipShape(Capsule()) }
}

#Preview {
    ClinicMapView()
}
