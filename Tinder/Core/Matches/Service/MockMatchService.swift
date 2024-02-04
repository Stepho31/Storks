//
//  MockMatchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

struct MockMatchService: MatchServiceProtocol {
    func checkForMatch(withUser user: User) async throws -> Bool {
        return false 
    }
    
    func fetchMatches() async throws -> [Match] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return DeveloperPreview.matches
    }
}
