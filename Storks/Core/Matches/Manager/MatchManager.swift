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
    
    private var isInitialLoad = true
    private var lastFetchTime = Date()
    
    init(service: MatchServiceProtocol) {
        self.service = service
        self.userService = UserService()
    }
    
    func fetchMatches() async {
        guard shouldRefreshMatches else {
            print("DEBUG: Don't fetch new matches yet..")
            return
        }
        
        do {
            matches = try await service.fetchMatches()
            
            await withThrowingTaskGroup(of: Void.self) { [weak self] group in
                guard let self else { return }
                
                for match in matches {
                    group.addTask { try await self.fetchUserDataForMatch(match) }
                }
            }
            self.lastFetchTime = Date()
        } catch {
            print("DEBUG: Failed to fetch matches with error: \(error)")
        }
    }
    
    // consider using a queue structure for matches
    func checkForMatch(fromUser user: User) async {
        do {
            let didMatch = try await service.checkForMatch(withUser: user)
            if didMatch {
                matchedUser = user
                await saveMatch(withUser: user)
            }
        } catch {
            print("DEBUG: Failed to check match with error: \(error)")
        }
    }
}

private extension MatchManager {
    func saveMatch(withUser user: User) async {
        do {
            try await service.saveMatch(withUser: user)
        } catch {
            print("DEBUG: Failed to save match with error: \(error)")
        }
    }
    
    func fetchUserDataForMatch(_ match: Match) async throws {
        guard let index = matches.firstIndex(where: { $0.id == match.id }) else { return }
        matches[index].user = try await userService.fetchUser(withUid: match.userId)
    }
}

private extension MatchManager {
    var refreshTimeIntervalInSeconds: Double {
        10 * 60
    }
    
    var shouldRefreshMatches: Bool {
        if isInitialLoad {
            isInitialLoad.toggle()
            return true
        }
        
        return abs(lastFetchTime.timeIntervalSinceNow) > refreshTimeIntervalInSeconds
    }
}
