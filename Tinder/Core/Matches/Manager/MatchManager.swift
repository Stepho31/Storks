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
    private var potentialMatchIDs = [String]()
    
    init(service: MatchServiceProtocol) {
        self.service = service
        
        Task { await fetchPotentialMatchIDs() }
        Task { await fetchMatches() }
    }
    
    func fetchMatches() async {
        do {
            self .matches = try await service.fetchMatches()
        } catch {
            print("DEBUG: Failed to fetch matches with error: \(error)")
        }
    }
    
    func fetchPotentialMatchIDs() async {
        do {
            potentialMatchIDs = try await service.fetchPotentialMatchIDs()
        } catch {
            print("DEBUG: Failed to fetch potential matches: \(error)")
        }
    }
    
    func checkForMatch(fromUser user: User) {
        guard potentialMatchIDs.contains(user.id) else { return }
        matchedUser = user
    }
    
    func removePotentialMatchIfNecessary(forUser user: User) {
        potentialMatchIDs.removeAll(where: { $0 == user.id })
    }
}
