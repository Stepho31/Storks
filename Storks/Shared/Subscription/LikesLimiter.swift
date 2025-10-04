//
//  LikesLimiter.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import Foundation
import Combine

final class LikesLimiter: ObservableObject {
    static let shared = LikesLimiter()
    @Published var presentPaywall: Bool = false
    
    private let calendar = Calendar.current
    private let storageKey = "likes.count"
    private let dateKey = "likes.date"
    private var userDefaults: UserDefaults { .standard }
    
    private init() {}
    
    func remainingLikesToday() -> Int {
        let plan: SubscriptionPlan = .free // This limiter is only referenced for free; caller guards otherwise
        let maxLikes = PlanGating.entitlements(for: plan).maxLikesPerDay ?? Int.max
        let (count, isToday) = currentCount()
        if !isToday { return maxLikes }
        return max(0, maxLikes - count)
    }
    
    func consumeLike() {
        let (count, isToday) = currentCount()
        if isToday {
            userDefaults.set(count + 1, forKey: storageKey)
        } else {
            userDefaults.set(1, forKey: storageKey)
            userDefaults.set(Date(), forKey: dateKey)
        }
    }
    
    private func currentCount() -> (count: Int, isToday: Bool) {
        let count = userDefaults.integer(forKey: storageKey)
        guard let date = userDefaults.object(forKey: dateKey) as? Date else {
            userDefaults.set(Date(), forKey: dateKey)
            return (0, true)
        }
        let isToday = calendar.isDateInToday(date)
        if !isToday {
            userDefaults.set(0, forKey: storageKey)
            userDefaults.set(Date(), forKey: dateKey)
        }
        return (userDefaults.integer(forKey: storageKey), calendar.isDateInToday(userDefaults.object(forKey: dateKey) as? Date ?? Date()))
    }
}
