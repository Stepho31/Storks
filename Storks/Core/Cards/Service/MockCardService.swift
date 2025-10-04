//
//  MockCardService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

struct MockCardService: CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let preferredGenders = currentUser.preferredGenders(for: currentUser)
        let preferredOrientations = currentUser.preferredOrientations(for: currentUser)
        
        return DeveloperPreview.users
            .filter({
                !currentUser.blockedUIDs.contains($0.id) &&
                preferredGenders.contains($0.gender) &&
                preferredOrientations.contains($0.sexualOrientation)
            })
            .map({ other in
                var model = CardModel(user: other)
                model.compatibilityScore = CompatibilityService.computeCompatibility(currentUser: currentUser, otherUser: other)
                return model
            })
    }
    
    func saveSwipe(forUser user: User, swipe: SwipeAction) async throws { }
    
    func resetCards(for currentUser: User) async throws { }

}
