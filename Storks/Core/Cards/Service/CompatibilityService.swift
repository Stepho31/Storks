//
//  CompatibilityService.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import Foundation

struct CompatibilityService {
    static func computeCompatibility(currentUser: User, otherUser: User) -> Int {
        var score = 0.0
        var totalWeight = 0.0
        
        // Parenting style match
        let parentingWeight = 0.30
        if let a = currentUser.parentingStyle, let b = otherUser.parentingStyle {
            score += (a == b ? 1.0 : 0.5) * parentingWeight
        } else {
            score += 0.25 * parentingWeight // partial credit if missing
        }
        totalWeight += parentingWeight
        
        // Family values overlap (Jaccard)
        let valuesWeight = 0.30
        if let va = Set(currentUser.familyValues ?? []), let vb = Set(otherUser.familyValues ?? []) {
            let intersection = Double(va.intersection(vb).count)
            let union = Double(va.union(vb).count)
            let jaccard = union > 0 ? intersection / union : 0.0
            score += jaccard * valuesWeight
        }
        totalWeight += valuesWeight
        
        // Availability overlap
        let availabilityWeight = 0.20
        if let aa = Set(currentUser.availabilityPresets ?? []), let ab = Set(otherUser.availabilityPresets ?? []) {
            let overlap = Double(aa.intersection(ab).count)
            let maxCount = Double(max(aa.count, ab.count))
            let ratio = maxCount > 0 ? overlap / maxCount : 0.0
            score += ratio * availabilityWeight
        }
        totalWeight += availabilityWeight
        
        // Relationship goal alignment (soft)
        let goalsWeight = 0.20
        if let ga = currentUser.relationshipGoals, let gb = otherUser.relationshipGoals {
            let aligned = ga == gb || (ga == .longTermOpenToShort || gb == .longTermOpenToShort) || (ga == .shortTermOpenToLong || gb == .shortTermOpenToLong)
            score += (aligned ? 1.0 : 0.25) * goalsWeight
        } else {
            score += 0.25 * goalsWeight
        }
        totalWeight += goalsWeight
        
        let normalized = totalWeight > 0 ? score / totalWeight : 0
        let percent = Int((normalized * 100.0).rounded())
        return max(0, min(100, percent))
    }
}
