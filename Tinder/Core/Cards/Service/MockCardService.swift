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
        let sexualPreference = currentUser.sexualPreference
        
        return DeveloperPreview.users
            .filter({ $0.gender == sexualPreference.preferredGender })
            .map({ CardModel(user: $0) })
    }
}
