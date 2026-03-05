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
        
      
        "entrance_left": MapNode(id: "entrance_left", name: "Main Entrance", position: CGPoint(x: 0.08, y: 0.53), connectedEdges: ["hall_reception"], isDestination: true),
        "reception": MapNode(id: "reception", name: "Reception", position: CGPoint(x: 0.21, y: 0.44), connectedEdges: ["hall_reception"], isDestination: true),
        "wash_room": MapNode(id: "wash_room", name: "Wash Room", position: CGPoint(x: 0.29, y: 0.66), connectedEdges: ["hall_washroom"], isDestination: true),
        "patient_restrooms": MapNode(id: "patient_restrooms", name: "Patient Restrooms", position: CGPoint(x: 0.29, y: 0.92), connectedEdges: ["hall_patient_restrooms"], isDestination: true),
        
        // -- Middle Wing (Up & Down) --
        "clinic_cafeteria": MapNode(id: "clinic_cafeteria", name: "Clinic Cafeteria", position: CGPoint(x: 0.50, y: 0.12), connectedEdges: ["hall_cafeteria"], isDestination: true),
        "elevator": MapNode(id: "elevator", name: "Elevator", position: CGPoint(x: 0.40, y: 0.63), connectedEdges: ["hall_elevator"], isDestination: true),
        "pharmacy": MapNode(id: "pharmacy", name: "Pharmacy", position: CGPoint(x: 0.60, y: 0.73), connectedEdges: ["hall_pharmacy"], isDestination: true),
        
        // -- Right Wing (Doctor Rooms) --
        "dr_room_1": MapNode(id: "dr_room_1", name: "Doctor Room 1", position: CGPoint(x: 0.62, y: 0.32), connectedEdges: ["hall_dr_1"], isDestination: true),
        "dr_room_2": MapNode(id: "dr_room_2", name: "Doctor Room 2", position: CGPoint(x: 0.62, y: 0.42), connectedEdges: ["hall_dr_2"], isDestination: true),
        "dr_room_3": MapNode(id: "dr_room_3", name: "Doctor Room 3", position: CGPoint(x: 0.68, y: 0.53), connectedEdges: ["hall_dr_3"], isDestination: true),
        "dr_room_4": MapNode(id: "dr_room_4", name: "Doctor Room 4", position: CGPoint(x: 0.85, y: 0.63), connectedEdges: ["hall_dr_4"], isDestination: true),
        "dr_room_5": MapNode(id: "dr_room_5", name: "Doctor Room 5", position: CGPoint(x: 0.85, y: 0.73), connectedEdges: ["hall_dr_5"], isDestination: true),
        "dr_room_6": MapNode(id: "dr_room_6", name: "Doctor Room 6", position: CGPoint(x: 0.85, y: 0.83), connectedEdges: ["hall_dr_6"], isDestination: true),
        "dr_room_7": MapNode(id: "dr_room_7", name: "Doctor Room 7", position: CGPoint(x: 0.85, y: 0.93), connectedEdges: ["hall_dr_7"], isDestination: true),

       
        
        // -- Main Horizontal Hallway (Left to Middle) --
        "hall_reception": MapNode(id: "hall_reception", name: "Hallway", position: CGPoint(x: 0.21, y: 0.53), connectedEdges: ["entrance_left", "reception", "hall_washroom"], isDestination: false),
        "hall_washroom": MapNode(id: "hall_washroom", name: "Hallway", position: CGPoint(x: 0.29, y: 0.53), connectedEdges: ["hall_reception", "wash_room", "hall_middle_cross"], isDestination: false),
        
        // -- Thick Vertical Middle Hallway (Top to Bottom) --
        "hall_cafeteria": MapNode(id: "hall_cafeteria", name: "Hallway", position: CGPoint(x: 0.50, y: 0.20), connectedEdges: ["clinic_cafeteria", "hall_dr_1"], isDestination: false),
        "hall_dr_1": MapNode(id: "hall_dr_1", name: "Hallway", position: CGPoint(x: 0.50, y: 0.32), connectedEdges: ["hall_cafeteria", "dr_room_1", "hall_dr_2"], isDestination: false),
        "hall_dr_2": MapNode(id: "hall_dr_2", name: "Hallway", position: CGPoint(x: 0.50, y: 0.42), connectedEdges: ["hall_dr_1", "dr_room_2", "hall_middle_cross"], isDestination: false),
        
        "hall_middle_cross": MapNode(id: "hall_middle_cross", name: "Main Intersection", position: CGPoint(x: 0.50, y: 0.53), connectedEdges: ["hall_washroom", "hall_dr_2", "hall_elevator", "hall_dr_3"], isDestination: false),
        
        "hall_elevator": MapNode(id: "hall_elevator", name: "Hallway", position: CGPoint(x: 0.50, y: 0.63), connectedEdges: ["hall_middle_cross", "elevator", "hall_pharmacy"], isDestination: false),
        "hall_pharmacy": MapNode(id: "hall_pharmacy", name: "Hallway", position: CGPoint(x: 0.50, y: 0.73), connectedEdges: ["hall_elevator", "pharmacy", "hall_bottom_cross"], isDestination: false),
        "hall_bottom_cross": MapNode(id: "hall_bottom_cross", name: "Bottom Intersection", position: CGPoint(x: 0.50, y: 0.82), connectedEdges: ["hall_pharmacy", "hall_patient_restrooms"], isDestination: false),
        
        // -- Bottom Horizontal Hallway --
        "hall_patient_restrooms": MapNode(id: "hall_patient_restrooms", name: "Hallway", position: CGPoint(x: 0.29, y: 0.82), connectedEdges: ["hall_bottom_cross", "patient_restrooms"], isDestination: false),

        // -- Right Wing Hallway (Connecting to Dr Rooms 4-7) --
        "hall_dr_3": MapNode(id: "hall_dr_3", name: "Hallway", position: CGPoint(x: 0.62, y: 0.53), connectedEdges: ["hall_middle_cross", "dr_room_3", "hall_right_cross"], isDestination: false),
        "hall_right_cross": MapNode(id: "hall_right_cross", name: "Right Intersection", position: CGPoint(x: 0.73, y: 0.53), connectedEdges: ["hall_dr_3", "hall_dr_4"], isDestination: false),
        "hall_dr_4": MapNode(id: "hall_dr_4", name: "Hallway", position: CGPoint(x: 0.73, y: 0.63), connectedEdges: ["hall_right_cross", "dr_room_4", "hall_dr_5"], isDestination: false),
        "hall_dr_5": MapNode(id: "hall_dr_5", name: "Hallway", position: CGPoint(x: 0.73, y: 0.73), connectedEdges: ["hall_dr_4", "dr_room_5", "hall_dr_6"], isDestination: false),
        "hall_dr_6": MapNode(id: "hall_dr_6", name: "Hallway", position: CGPoint(x: 0.73, y: 0.83), connectedEdges: ["hall_dr_5", "dr_room_6", "hall_dr_7"], isDestination: false),
        "hall_dr_7": MapNode(id: "hall_dr_7", name: "Hallway", position: CGPoint(x: 0.73, y: 0.93), connectedEdges: ["hall_dr_6", "dr_room_7"], isDestination: false)
    ]
    
    // Sorts the rooms alphabetically for the search bar
    var searchableDestinations: [MapNode] {
        nodes.values
            .filter { $0.isDestination }
            .sorted { $0.name < $1.name }
    }
}
