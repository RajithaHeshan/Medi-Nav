import Foundation

struct MapNode: Identifiable, Equatable {
    let id: String
    let name: String
    let position: CGPoint
    let connectedEdges: [String]
    let isDestination: Bool
}

class ClinicMapData {
    static let shared = ClinicMapData()
    
    let nodes: [String: MapNode] = [
        
       
        "entrance_left": MapNode(
            id: "entrance_left",
            name: "Main Entrance",
            // Adjusted X to start perfectly at the left door
            position: CGPoint(x: 0.08, y: 0.53),
            connectedEdges: ["hall_reception"],
            isDestination: true
        ),
        
        "reception": MapNode(
            id: "reception",
            name: "Reception",
            position: CGPoint(x: 0.23, y: 0.44),
            connectedEdges: ["hall_reception"],
            isDestination: true
        ),
        
        "wash_room": MapNode(
            id: "wash_room",
            name: "Wash Room",
            position: CGPoint(x: 0.35, y: 0.68),
            connectedEdges: ["hall_washroom"],
            isDestination: true
        ),
        
        "dr_room_3": MapNode(
            id: "dr_room_3",
            name: "Doctor Room 3",
            // Adjusted to sit right next to the middle vertical hallway
            position: CGPoint(x: 0.64, y: 0.53),
            connectedEdges: ["hall_middle_cross"],
            isDestination: true
        ),
        
        "pharmacy": MapNode(
            id: "pharmacy",
            name: "Pharmacy",
            // Adjusted to perfectly hit the orange box
            position: CGPoint(x: 0.65, y: 0.73),
            connectedEdges: ["hall_pharmacy"],
            isDestination: true
        ),
        
        // ==========================================
        // 🔴 HALLWAY INTERSECTIONS (Invisible turns)
        // ==========================================
        
        "hall_reception": MapNode(
            id: "hall_reception",
            name: "Hallway (Reception)",
            position: CGPoint(x: 0.23, y: 0.53),
            connectedEdges: ["entrance_left", "reception", "hall_washroom"],
            isDestination: false
        ),
        
        "hall_washroom": MapNode(
            id: "hall_washroom",
            name: "Hallway (Washroom)",
            position: CGPoint(x: 0.35, y: 0.53),
            connectedEdges: ["hall_reception", "wash_room", "hall_middle_cross"],
            isDestination: false
        ),
        
        "hall_middle_cross": MapNode(
            id: "hall_middle_cross",
            name: "Main Middle Intersection",
            // Pulled left to align with the thick middle hallway
            position: CGPoint(x: 0.56, y: 0.53),
            connectedEdges: ["hall_washroom", "dr_room_3", "hall_pharmacy"],
            isDestination: false
        ),
        
        "hall_pharmacy": MapNode(
            id: "hall_pharmacy",
            name: "Hallway (Pharmacy)",
            // Pulled left to align with the thick middle hallway
            position: CGPoint(x: 0.56, y: 0.73),
            connectedEdges: ["hall_middle_cross", "pharmacy"],
            isDestination: false
        )
    ]
    
    var searchableDestinations: [MapNode] {
        nodes.values
            .filter { $0.isDestination }
            .sorted { $0.name < $1.name }
    }
}
