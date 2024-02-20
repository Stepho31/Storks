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
        
        return DeveloperPreview.users
            .filter({ !currentUser.blockedUIDs.contains($0.id) })
            .map({ CardModel(user: $0) })
    }
    
    func saveSwipe(forUser user: User, swipe: SwipeAction) async throws { }
    
    func resetCards(for currentUser: User) async throws { }

}
