import Foundation

struct NavigationEngine {
    
    /// Finds the shortest path between two points on our map graph
    static func findPath(from startID: String, to endID: String) -> [CGPoint] {
        let graph = ClinicMapData.shared.nodes
        
        // Safety check: Make sure both nodes actually exist in our database
        guard let startNode = graph[startID], let endNode = graph[endID] else { return [] }
        
        // If the user is already there, just return the current point
        if startID == endID { return [startNode.position] }
        
        // BFS Algorithm Setup
        // 'queue' stores the paths we are currently exploring
        var queue: [[String]] = [[startID]]
        var visited = Set<String>()
        
        while !queue.isEmpty {
            let currentPath = queue.removeFirst() // Get the first path in the queue
            guard let currentNodeID = currentPath.last else { continue }
            
            // Did we reach the destination?
            if currentNodeID == endID {
                // We found the shortest route! Convert the IDs into actual X/Y coordinates
                return currentPath.compactMap { graph[$0]?.position }
            }
            
            // If we haven't checked this intersection yet, check it now
            if !visited.contains(currentNodeID) {
                visited.insert(currentNodeID)
                
                // Look down all connected hallways
                if let node = graph[currentNodeID] {
                    for neighborID in node.connectedEdges {
                        if !visited.contains(neighborID) {
                            var newPath = currentPath
                            newPath.append(neighborID)
                            queue.append(newPath) // Add this new path to explore
                        }
                    }
                }
            }
        }
        
        return [] // Return empty if no path is possible
    }
}
