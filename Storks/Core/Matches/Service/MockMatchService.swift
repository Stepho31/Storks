//
//  MockMatchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

struct MockMatchService: MatchServiceProtocol {
    func saveMatch(withUser user: User) async throws {
        
    }
    
    func checkForMatch(withUser user: User) async throws -> Bool {
        return Bool.random()
    }
    
    func fetchMatches() async throws -> [Match] {
        return DeveloperPreview.matches
    }
}
