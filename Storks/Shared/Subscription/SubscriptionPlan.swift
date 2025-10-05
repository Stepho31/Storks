//
//  SubscriptionPlan.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import Foundation

enum SubscriptionPlan: String, Codable, CaseIterable, Identifiable {
    case free
    case plus
    case premium
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .free: return "Free"
        case .plus: return "Storks Plus"
        case .premium: return "Storks Premium"
        }
    }
}

struct PlanEntitlements: Codable, Hashable {
    let maxLikesPerDay: Int?
    let unlimitedLikes: Bool
    let unlimitedMatches: Bool
    let advancedFilters: Bool
    let prioritySearchPlacement: Bool
    let readReceipts: Bool
    let aiDateConcierge: Bool
    let profileBoostsPerMonth: Int
    let premiumForumsAndEvents: Bool
    let aiConversationStarters: Bool
    let skipTheLineMatching: Bool
}

enum PlanGating {
    static func entitlements(for plan: SubscriptionPlan) -> PlanEntitlements {
        switch plan {
        case .free:
            return PlanEntitlements(
                maxLikesPerDay: 20,
                unlimitedLikes: false,
                unlimitedMatches: false,
                advancedFilters: false,
                prioritySearchPlacement: false,
                readReceipts: false,
                aiDateConcierge: false,
                profileBoostsPerMonth: 0,
                premiumForumsAndEvents: false,
                aiConversationStarters: false,
                skipTheLineMatching: false
            )
        case .plus:
            return PlanEntitlements(
                maxLikesPerDay: nil,
                unlimitedLikes: true,
                unlimitedMatches: true,
                advancedFilters: true,
                prioritySearchPlacement: true,
                readReceipts: true,
                aiDateConcierge: false,
                profileBoostsPerMonth: 0,
                premiumForumsAndEvents: false,
                aiConversationStarters: false,
                skipTheLineMatching: false
            )
        case .premium:
            return PlanEntitlements(
                maxLikesPerDay: nil,
                unlimitedLikes: true,
                unlimitedMatches: true,
                advancedFilters: true,
                prioritySearchPlacement: true,
                readReceipts: true,
                aiDateConcierge: true,
                profileBoostsPerMonth: 5,
                premiumForumsAndEvents: true,
                aiConversationStarters: true,
                skipTheLineMatching: true
            )
        }
    }
    
    static func rank(for plan: SubscriptionPlan) -> Int {
        switch plan {
        case .free: return 0
        case .plus: return 1
        case .premium: return 2
        }
    }
}
