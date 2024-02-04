//
//  MatchManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

@MainActor
class MatchManager: ObservableObject {
    
    @Published var matchedUser: User?
    @Published var matches = [Match]()
    
    private let service: MatchServiceProtocol
    
    init(service: MatchServiceProtocol) {
        self.service = service
        
        Task { await fetchMatches() }
    }
    
    func fetchMatches() async {
        do {
            self .matches = try await service.fetchMatches()
        } catch {
            print("DEBUG: Failed to fetch matches with error: \(error)")
        }
    }
    
    // consider using a queue structure for matches
    func checkForMatch(fromUser user: User) async  {
        do {
            let didMatch = try await service.checkForMatch(withUser: user)
            if didMatch { matchedUser = user }
        } catch {
            print("DEBUG: Failed to check match with error: \(error)")
        }
    }
}
