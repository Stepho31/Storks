//
//  MockMatchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

struct MatchService: MatchServiceProtocol {
    func fetchPotentialMatchIDs() async throws -> [String] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return ["abc"]
    }
    
    func fetchMatches() async throws -> [Match] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return DeveloperPreview.matches
    }
}
