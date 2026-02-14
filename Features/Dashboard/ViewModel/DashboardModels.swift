import Foundation
import SwiftUI


struct VisitStep: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let time: String?
    let status: StepStatus
    
    enum StepStatus {
        case completed
        case current
        case pending
    }
}


struct MenuOption: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String // Use this for custom assets
    let systemIcon: String // Use this for SF Symbols fallback
}
