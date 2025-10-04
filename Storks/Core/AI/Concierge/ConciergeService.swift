//
//  ConciergeService.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import Foundation

struct ConciergePlan: Codable, Hashable {
    let kidFree: Bool
    let timeWindow: AvailabilityPreset
    let locationHint: String?
    let reservations: [String]
    let childcare: String?
    let transportation: String?
}

final class ConciergeService {
    func generatePlan(kidFree: Bool, timeWindow: AvailabilityPreset, location: String?) async -> ConciergePlan {
        // Placeholder: integrate with AI + provider APIs
        let reservations = kidFree ? ["Dinner at Cozy Bistro"] : ["Family-friendly cafe"]
        let childcare = kidFree ? "Sitter booked via TrustedSitters" : nil
        let transportation = "Ride reserved 6:45pm"
        return ConciergePlan(kidFree: kidFree, timeWindow: timeWindow, locationHint: location, reservations: reservations, childcare: childcare, transportation: transportation)
    }
}
