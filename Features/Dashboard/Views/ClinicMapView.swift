//import SwiftUI
//
//struct ClinicMapView: View {
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.openURL) var openURL
//    
//    
//    @State private var searchText = ""
//    @State private var isSearchActive = false
//    
//   
//    @State private var routePath: [CGPoint] = []
//    @State private var currentDotPosition: CGPoint = CGPoint(x: 0.05, y: 0.52)
//    @State private var isNavigating = false
//    @State private var selectedDestinationName: String? = nil
//    
// 
//    @State private var tappedNode: MapNode? = nil
//    @State private var showDetailsSheet = false
//    @State private var pulseAnimation = false
//    
//
//    @State private var scale: CGFloat = 1.0
//    @State private var lastScale: CGFloat = 1.0
//    @State private var offset: CGSize = .zero
//    @State private var lastOffset: CGSize = .zero
//    
//    let startingLocationID = "entrance_left"
//    
//    var body: some View {
//        ZStack {
//            
//          
//            Color(uiColor: .systemGroupedBackground)
//                .ignoresSafeArea()
//            
//          
//            mapContent
//            
//           
//            VStack(spacing: 0) {
//                Spacer()
//                
//               
//                HStack {
//                    Spacer()
//                    zoomControls
//                }
//                .padding(.trailing, 16)
//                .padding(.bottom, 16)
//                
//             
//                bottomActionArea
//            }
//        }
//        .navigationTitle("Clinic Navigation")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button { dismiss() } label: {
//                    Image(systemName: "chevron.left")
//                        .font(.body.weight(.semibold))
//                        .foregroundStyle(Color(uiColor: .label))
//                }
//            }
//        }
//        .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a room or department...")
//        .searchSuggestions {
//            if !searchText.isEmpty {
//                ForEach(searchResults, id: \.id) { node in
//                    Button {
//                        selectDestination(node: node)
//                    } label: {
//                        HStack {
//                            Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue)
//                            Text(node.name).font(.body).foregroundStyle(Color(uiColor: .label))
//                        }
//                    }
//                }
//            }
//        }
//        .onSubmit(of: .search) {
//            if let bestMatch = searchResults.first { selectDestination(node: bestMatch) }
//        }
//        .sheet(isPresented: $showDetailsSheet) {
//            if let node = tappedNode { RoomDetailsView(node: node) }
//        }
//    }
//    
//    
//    
//    private var mapContent: some View {
//        Image("ClinicMapImage")
//            .resizable()
//            .scaledToFit()
//            .padding(.horizontal, 8)
//            .overlay(
//                GeometryReader { geometry in
//                    ZStack(alignment: .topLeading) {
//                        
//                        Color.clear
//                            .contentShape(Rectangle())
//                            .onTapGesture { location in
//                                handleMapTap(at: location, in: geometry.size)
//                            }
//                        
//                        Path { path in
//                            guard let first = routePath.first else { return }
//                            path.move(to: convert(point: first, in: geometry.size))
//                            for point in routePath.dropFirst() {
//                                path.addLine(to: convert(point: point, in: geometry.size))
//                            }
//                        }
//                        .stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 5, dash: [8, 6]))
//                        
//                        if !routePath.isEmpty {
//                            Circle()
//                                .fill(Color.blue).frame(width: 18, height: 18)
//                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
//                                .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0)
//                                .position(convert(point: currentDotPosition, in: geometry.size))
//                        }
//                        
//                        if let tapped = tappedNode {
//                            ZStack {
//                                Circle()
//                                    .fill(Color.red.opacity(0.3)).frame(width: 50, height: 50)
//                                    .scaleEffect(pulseAnimation ? 1.2 : 0.8)
//                                    .opacity(pulseAnimation ? 0 : 1)
//                                
//                                Circle()
//                                    .fill(Color.red).frame(width: 16, height: 16)
//                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
//                                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
//                            }
//                            .position(convert(point: tapped.position, in: geometry.size))
//                            .onAppear {
//                                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) { pulseAnimation = true }
//                            }
//                        }
//                    }
//                }
//            )
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .scaleEffect(scale)
//            .offset(offset)
//            .gesture(magnification.simultaneously(with: drag))
//            .clipped()
//    }
//    
//    private var zoomControls: some View {
//        VStack(spacing: 0) {
//            Button(action: zoomIn) {
//                Image(systemName: "plus").font(.title2).frame(width: 44, height: 44).foregroundStyle(Color(uiColor: .label))
//            }
//            Divider().frame(width: 44)
//            Button(action: zoomOut) {
//                Image(systemName: "minus").font(.title2).frame(width: 44, height: 44).foregroundStyle(Color(uiColor: .label))
//            }
//        }
//        .frame(width: 44)
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
//    }
//    
//    @ViewBuilder
//    private var bottomActionArea: some View {
//        VStack {
//            if let tapped = tappedNode {
//                LocationPopupCard(node: tapped) {
//                    showDetailsSheet = true
//                } onClose: {
//                    withAnimation { tappedNode = nil; pulseAnimation = false }
//                }
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//                .padding(.bottom, 90)
//            } else if let destName = selectedDestinationName {
//                VStack(spacing: 12) {
//                    Text("Navigating to: \(destName)").font(.headline)
//                    Button(action: startNavigationAnimation) {
//                        HStack {
//                            Image(systemName: isNavigating ? "figure.walk" : "play.fill")
//                            Text(isNavigating ? "Navigating..." : "Start Route")
//                        }
//                        .font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding()
//                        .background(isNavigating ? Color.gray : Color.blue).clipShape(RoundedRectangle(cornerRadius: 12))
//                    }
//                    .disabled(isNavigating)
//                }
//                .padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24))
//                .shadow(color: Color.black.opacity(0.08), radius: 10, y: -5)
//                .padding(.horizontal, 16).padding(.bottom, 16)
//                //.transition(.move(edge: .bottom).combined(with: .opacity))
//                .padding(.bottom, 90)
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//            } else {
//                
//               
//                Button {
//                    if let url = URL(string: "https://googleusercontent.com/maps.google.com/16") {
//                        openURL(url)
//                    }
//                } label: {
//                    HStack(spacing: 8) {
//                        Image(systemName: "map.fill").font(.title3)
//                        Text("Mega Clinic Location").fontWeight(.medium)
//                    }
//                    .font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(Color.blue).clipShape(Capsule()).shadow(color: Color.blue.opacity(0.3), radius: 10, y: 5)
//                }
//                .padding(.horizontal, 20).padding(.bottom, 16)
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//                .padding(.bottom, 90)
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//                
//            }
//        }
//    }
//    
//
//    
//    var magnification: some Gesture {
//        MagnificationGesture()
//            .onChanged { value in
//                let delta = value / lastScale
//                lastScale = value
//                scale = min(max(scale * delta, 1), 4)
//            }
//            .onEnded { _ in
//                lastScale = 1.0
//                if scale <= 1.0 { withAnimation { offset = .zero; lastOffset = .zero } }
//            }
//    }
//    
//    var drag: some Gesture {
//        DragGesture(minimumDistance: 15)
//            .onChanged { value in
//                if scale > 1.0 {
//                    offset = CGSize(width: lastOffset.width + value.translation.width, height: lastOffset.height + value.translation.height)
//                }
//            }
//            .onEnded { _ in lastOffset = offset }
//    }
//    
//    private func zoomIn() { withAnimation { scale = min(scale + 0.5, 4.0) } }
//    
//    private func zoomOut() {
//        withAnimation {
//            scale = max(scale - 0.5, 1.0)
//            if scale == 1.0 { offset = .zero; lastOffset = .zero }
//        }
//    }
//    
//    var searchResults: [MapNode] {
//        let allDestinations = ClinicMapData.shared.searchableDestinations
//        if searchText.isEmpty { return allDestinations } else { return allDestinations.filter { $0.name.localizedCaseInsensitiveContains(searchText) } }
//    }
//    
//    private func convert(point: CGPoint, in size: CGSize) -> CGPoint {
//        return CGPoint(x: point.x * size.width, y: point.y * size.height)
//    }
//    
//    private func selectDestination(node: MapNode) {
//        isSearchActive = false
//        
//        selectedDestinationName = node.name
//        searchText = node.name
//        tappedNode = nil
//        withAnimation {
//            routePath = NavigationEngine.findPath(from: startingLocationID, to: node.id)
//            if let firstPoint = routePath.first { currentDotPosition = firstPoint }
//            scale = 1.0; offset = .zero; lastOffset = .zero
//        }
//    }
//    
//    private func handleMapTap(at location: CGPoint, in size: CGSize) {
//        isSearchActive = false
//        
//        let relativeTap = CGPoint(x: location.x / size.width, y: location.y / size.height)
//        var closestNode: MapNode? = nil
//        var minDistance: CGFloat = 0.10
//        
//        for node in ClinicMapData.shared.searchableDestinations {
//            let dx = relativeTap.x - node.position.x
//            let dy = relativeTap.y - node.position.y
//            let distance = sqrt(dx*dx + dy*dy)
//            
//            if distance < minDistance {
//                minDistance = distance
//                closestNode = node
//            }
//        }
//        
//        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
//            routePath = []
//            selectedDestinationName = nil
//            searchText = ""
//            
//            if tappedNode != closestNode {
//                pulseAnimation = false
//                tappedNode = closestNode
//            } else {
//                tappedNode = closestNode
//            }
//        }
//    }
//    
//    private func startNavigationAnimation() {
//        guard !routePath.isEmpty else { return }
//        isNavigating = true
//        Task {
//            for point in routePath {
//                await MainActor.run { withAnimation(.linear(duration: 1.0)) { currentDotPosition = point } }
//                try? await Task.sleep(nanoseconds: 1_000_000_000)
//            }
//            await MainActor.run { isNavigating = false }
//        }
//    }
//}
//
//
//
//struct LocationPopupCard: View {
//    let node: MapNode
//    let onDetailsTapped: () -> Void
//    let onClose: () -> Void
//    
//    var isAvailable: Bool { return node.id != "dr_room_6" }
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            Capsule().fill(Color.gray.opacity(0.3)).frame(width: 40, height: 4)
//            
//            HStack(alignment: .top) {
//                VStack(alignment: .leading, spacing: 6) {
//                    Text(node.name).font(.title2).fontWeight(.bold)
//                    
//                    HStack(spacing: 6) {
//                        Image(systemName: "building.2").foregroundStyle(.gray)
//                        Text("Ground Floor").foregroundStyle(.secondary)
//                    }
//                    .font(.subheadline)
//                    
//                    HStack(spacing: 6) {
//                        Circle().fill(isAvailable ? Color.green : Color.red).frame(width: 8, height: 8)
//                        Text(isAvailable ? "Available" : "Unavailable").font(.subheadline).fontWeight(.medium).foregroundStyle(isAvailable ? .green : .red)
//                    }
//                    .padding(.top, 2)
//                }
//                Spacer()
//                
//                Button(action: onClose) {
//                    Image(systemName: "xmark").font(.system(size: 14, weight: .bold)).foregroundStyle(.gray).padding(8).background(Color(uiColor: .systemGray6)).clipShape(Circle())
//                }
//            }
//            
//            Button(action: onDetailsTapped) {
//                Text("Details").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//        }
//        .padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24)).shadow(color: Color.black.opacity(0.15), radius: 20, y: 10).padding(.horizontal, 16).padding(.bottom, 20)
//    }
//}
//
//struct RoomDetailsView: View {
//    @Environment(\.dismiss) var dismiss
//    let node: MapNode
//    var isAvailable: Bool { return node.id != "dr_room_6" }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 24) {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(node.name).font(.largeTitle).fontWeight(.bold)
//                        HStack {
//                            Image(systemName: "building.2").foregroundStyle(.gray)
//                            Text("Ground Floor").foregroundStyle(.secondary)
//                        }
//                    }
//                    
//                    Divider()
//                    
//                    VStack(alignment: .leading, spacing: 20) {
//                        Text("Room Information").font(.headline).fontWeight(.bold)
//                        
//                        DetailRow(icon: "circle.fill", title: "Status", value: isAvailable ? "Available" : "Unavailable", valueColor: isAvailable ? .green : .red)
//                        DetailRow(icon: "number", title: "Room ID", value: "RM-\(node.id.suffix(4).uppercased())")
//                        DetailRow(icon: "building.2", title: "Floor", value: "Ground Floor")
//                        DetailRow(icon: "location", title: "Position", value: "(\(String(format: "%.2f", node.position.x)), \(String(format: "%.2f", node.position.y)))")
//                        
//                        VStack(alignment: .leading, spacing: 12) {
//                            HStack {
//                                Image(systemName: "magnifyingglass").foregroundStyle(.gray)
//                                Text("Search Terms").font(.subheadline).fontWeight(.medium)
//                            }
//                            HStack {
//                                SearchTag(text: node.name.lowercased())
//                                SearchTag(text: "clinic")
//                                SearchTag(text: "room")
//                            }
//                        }
//                    }
//                }
//                .padding(24)
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Done") { dismiss() }.fontWeight(.semibold).padding(.horizontal, 12).padding(.vertical, 6).background(Color(uiColor: .systemGray6)).clipShape(Capsule())
//                }
//            }
//        }
//    }
//}
//
//struct DetailRow: View {
//    let icon: String
//    let title: String
//    let value: String
//    var valueColor: Color = .secondary
//    var body: some View {
//        HStack { Image(systemName: icon).frame(width: 24).foregroundStyle(.gray); Text(title).fontWeight(.medium); Spacer(); Text(value).foregroundStyle(valueColor) }.font(.subheadline)
//    }
//}
//
//struct SearchTag: View {
//    let text: String
//    var body: some View { Text(text).font(.caption).foregroundStyle(.blue).padding(.horizontal, 12).padding(.vertical, 6).background(Color.blue.opacity(0.1)).clipShape(Capsule()) }
//}
//
//#Preview {
//    NavigationStack {
//        ClinicMapView()
//    }
//}

import SwiftUI

struct ClinicMapView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State private var searchText = ""
    @State private var isSearchActive = false
    
    // Voice Search States
    @State private var isListening = false
    
    @State private var routePath: [CGPoint] = []
    @State private var currentDotPosition: CGPoint = CGPoint(x: 0.05, y: 0.52)
    @State private var isNavigating = false
    @State private var selectedDestinationName: String? = nil
    
    @State private var tappedNode: MapNode? = nil
    @State private var showDetailsSheet = false
    @State private var pulseAnimation = false

    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    let startingLocationID = "entrance_left"
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            mapContent
            
            VStack(spacing: 0) {
                // 1. Updated Search Bar Area with Mic
                searchBarArea
                
                Spacer()
                
                HStack {
                    Spacer()
                    zoomControls
                }
                .padding(.trailing, 16)
                .padding(.bottom, 16)
                
                bottomActionArea
            }
            
            // 2. Voice Overlay
            if isListening {
                voiceAnimationOverlay
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showDetailsSheet) {
            if let node = tappedNode { RoomDetailsView(node: node) }
        }
    }
    
    // MARK: - Subviews
    
    private var searchBarArea: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color(uiColor: .label))
                        .padding(10)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(Circle())
                }
                Text("Clinic Navigation").font(.headline)
                Spacer()
            }
            .padding(.horizontal).padding(.top, 8)
            
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Search for a room...", text: $searchText)
                    
                    if !searchText.isEmpty {
                        Button { searchText = "" } label: { Image(systemName: "xmark.circle.fill").foregroundColor(.gray) }
                    }
                    
                    Divider().frame(height: 20).padding(.horizontal, 4)
                    
                    Button { withAnimation { isListening = true } } label: {
                        Image(systemName: "mic.fill").foregroundStyle(.blue).font(.system(size: 18))
                    }
                }
                .padding(.vertical, 12).padding(.horizontal, 16)
                .background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
            }.padding(.horizontal)
            
            if !searchText.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(searchResults, id: \.id) { node in
                            Button { selectDestination(node: node); searchText = "" } label: {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse").foregroundStyle(.blue)
                                    Text(node.name).foregroundStyle(Color(uiColor: .label))
                                    Spacer()
                                }.padding()
                            }
                            Divider().padding(.horizontal)
                        }
                    }
                    .background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 15)).padding(.horizontal)
                    .frame(maxHeight: 200)
                }
            }
        }
    }

    private var voiceAnimationOverlay: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 25) {
                Text("Listening...").font(.headline).foregroundStyle(.white)
                HStack(spacing: 4) {
                    ForEach(0..<8) { _ in
                        RoundedRectangle(cornerRadius: 2).fill(.white)
                            .frame(width: 4, height: CGFloat.random(in: 10...60))
                            .animation(.easeInOut(duration: 0.15).repeatForever(), value: isListening)
                    }
                }
                Button { isListening = false } label: {
                    Image(systemName: "xmark").font(.title2).foregroundStyle(.white).padding(20).background(.red).clipShape(Circle())
                }
            }.padding(40).background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }

    private var mapContent: some View {
        Image("ClinicMapImage").resizable().scaledToFit().padding(.horizontal, 8)
            .overlay(GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    Color.clear.contentShape(Rectangle()).onTapGesture { location in handleMapTap(at: location, in: geometry.size) }
                    Path { path in
                        guard let first = routePath.first else { return }
                        path.move(to: convert(point: first, in: geometry.size))
                        for pt in routePath.dropFirst() { path.addLine(to: convert(point: pt, in: geometry.size)) }
                    }.stroke(Color.blue.opacity(0.6), style: StrokeStyle(lineWidth: 5, dash: [8, 6]))
                    if !routePath.isEmpty {
                        Circle().fill(.blue).frame(width: 18, height: 18).overlay(Circle().stroke(.white, lineWidth: 3))
                            .position(convert(point: currentDotPosition, in: geometry.size))
                    }
                    if let tapped = tappedNode {
                        ZStack {
                            Circle().fill(.red.opacity(0.3)).frame(width: 50, height: 50).scaleEffect(pulseAnimation ? 1.2 : 0.8).opacity(pulseAnimation ? 0 : 1)
                            Circle().fill(.red).frame(width: 16, height: 16).overlay(Circle().stroke(.white, lineWidth: 3))
                        }
                        .position(convert(point: tapped.position, in: geometry.size))
                        .onAppear { withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) { pulseAnimation = true } }
                    }
                }
            })
            .scaleEffect(scale).offset(offset).gesture(magnification.simultaneously(with: drag)).clipped()
    }

    private var zoomControls: some View {
        VStack(spacing: 0) {
            Button(action: zoomIn) { Image(systemName: "plus").frame(width: 44, height: 44) }
            Divider().frame(width: 44)
            Button(action: zoomOut) { Image(systemName: "minus").frame(width: 44, height: 44) }
        }.background(.ultraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 10)).foregroundStyle(Color(uiColor: .label))
    }

    @ViewBuilder
    private var bottomActionArea: some View {
        VStack {
            if let tapped = tappedNode {
                LocationPopupCard(node: tapped) { showDetailsSheet = true } onClose: { withAnimation { tappedNode = nil } }
                    .padding(.bottom, 90)
            } else if let destName = selectedDestinationName {
                VStack(spacing: 12) {
                    Text("Navigating to: \(destName)").font(.headline)
                    Button(action: startNavigationAnimation) {
                        Label(isNavigating ? "Navigating..." : "Start Route", systemImage: isNavigating ? "figure.walk" : "play.fill")
                            .font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding()
                            .background(isNavigating ? .gray : .blue).clipShape(RoundedRectangle(cornerRadius: 12))
                    }.disabled(isNavigating)
                }.padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24)).padding(.bottom, 90)
            } else {
                Button { if let url = URL(string: "http://maps.google.com") { openURL(url) } } label: {
                    Label("Mega Clinic Location", systemImage: "map.fill").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(.blue).clipShape(Capsule())
                }.padding(.horizontal, 20).padding(.bottom, 90)
            }
        }
    }

    // MARK: - Logic Helpers
    var magnification: some Gesture { MagnificationGesture().onChanged { v in scale = min(max(scale * (v / lastScale), 1), 4); lastScale = v }.onEnded { _ in lastScale = 1.0 } }
    var drag: some Gesture { DragGesture().onChanged { v in if scale > 1.0 { offset = CGSize(width: lastOffset.width + v.translation.width, height: lastOffset.height + v.translation.height) } }.onEnded { _ in lastOffset = offset } }
    private func zoomIn() { withAnimation { scale = min(scale + 0.5, 4.0) } }
    private func zoomOut() { withAnimation { scale = max(scale - 0.5, 1.0); if scale == 1.0 { offset = .zero } } }
    var searchResults: [MapNode] { ClinicMapData.shared.searchableDestinations.filter { searchText.isEmpty ? false : $0.name.localizedCaseInsensitiveContains(searchText) } }
    private func convert(point: CGPoint, in size: CGSize) -> CGPoint { CGPoint(x: point.x * size.width, y: point.y * size.height) }
    private func selectDestination(node: MapNode) { selectedDestinationName = node.name; tappedNode = nil; withAnimation { routePath = NavigationEngine.findPath(from: startingLocationID, to: node.id); currentDotPosition = routePath.first ?? .zero } }
    private func handleMapTap(at location: CGPoint, in size: CGSize) {
        let rel = CGPoint(x: location.x / size.width, y: location.y / size.height)
        if let node = ClinicMapData.shared.searchableDestinations.first(where: { sqrt(pow(rel.x - $0.position.x, 2) + pow(rel.y - $0.position.y, 2)) < 0.05 }) {
            withAnimation { tappedNode = node; routePath = []; selectedDestinationName = nil }
        }
    }
    private func startNavigationAnimation() {
        isNavigating = true
        Task {
            for pt in routePath {
                await MainActor.run { withAnimation(.linear(duration: 1.0)) { currentDotPosition = pt } }
                try? await Task.sleep(nanoseconds: 1_000_000_000)
            }
            isNavigating = false
        }
    }
}

// MARK: - KEEPING YOUR ORIGINAL COMPONENTS
struct LocationPopupCard: View {
    let node: MapNode
    let onDetailsTapped: () -> Void
    let onClose: () -> Void
    var body: some View {
        VStack(spacing: 16) {
            Capsule().fill(.gray.opacity(0.3)).frame(width: 40, height: 4)
            HStack {
                VStack(alignment: .leading) {
                    Text(node.name).font(.title2).fontWeight(.bold)
                    Text("Ground Floor").font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Button(action: onClose) { Image(systemName: "xmark").padding(8).background(Color(uiColor: .systemGray6)).clipShape(Circle()) }
            }
            Button(action: onDetailsTapped) { Text("Details").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 14).background(.blue).clipShape(RoundedRectangle(cornerRadius: 12)) }
        }.padding(20).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24)).shadow(radius: 10).padding(.horizontal, 16)
    }
}

struct RoomDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let node: MapNode
    var body: some View {
        NavigationStack {
            List {
                Section("Room Information") {
                    LabeledContent("Name", value: node.name)
                    LabeledContent("Floor", value: "Ground Floor")
                }
            }.navigationTitle("Details").toolbar { Button("Done") { dismiss() } }
        }
    }
}
