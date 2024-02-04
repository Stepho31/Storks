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
    private let userService: UserServiceProtocol
    
    init(service: MatchServiceProtocol) {
        self.service = service
        self.userService = UserService()
        
        Task { await fetchMatches() }
    }
    
    func fetchMatches() async {
        do {
            matches = try await service.fetchMatches()
            
            await withThrowingTaskGroup(of: Void.self) { [weak self] group in
                guard let self else { return }
                
                for match in matches {
                    group.addTask { try await self.fetchUserDataForMatch(match) }
                }
            }
            
        } catch {
            print("DEBUG: Failed to fetch matches with error: \(error)")
        }
    }
    
    // consider using a queue structure for matches
    func checkForMatch(fromUser user: User, currentUser: User?) async {
        do {
            let didMatch = try await service.checkForMatch(withUser: user)
            
            if didMatch {
                matchedUser = user
                guard let currentUser else { return }
                await saveMatch(withUser: user, currentUser: currentUser)
            }
        } catch {
            print("DEBUG: Failed to check match with error: \(error)")
        }
    }
    
    private func saveMatch(withUser user: User, currentUser: User) async {
        do {
            try await service.saveMatch(withUser: user, currentUser: currentUser)
        } catch {
            print("DEBUG: Failed to save match with error: \(error)")
        }
    }
    
    private func fetchUserDataForMatch(_ match: Match) async throws {
        guard let index = matches.firstIndex(where: { $0.id == match.id }) else { return }
        
        async let user = userService.fetchUser(withUid: match.userId)
        matches[index].user = try await user
    }
}
