//
//  CardsViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import Foundation
import Combine

enum CardStackState {
    case loading
    case empty
    case hasData
}

@MainActor
class CardsViewModel: ObservableObject {
    @Published var cardModels = [CardModel]()
    @Published var animatedSwipeAction: SwipeAction?
    @Published var animating = false
    @Published var matchedUser: User?
    @Published var cardStackState: CardStackState = .empty
    
    var currentUser: User?
    var potentialMatchIDs = [String]()
    
    private let userManager: UserManager
    private var cancellables = Set<AnyCancellable>()
    
    init(userManager: UserManager) {
        self.userManager = userManager
                
        fetchCurrentUserCards()
    }
    
    private func fetchCurrentUserCards() {
        cardStackState = .loading
        
        Task {
            currentUser = userManager.currentUser
            
            if currentUser == nil {
                currentUser = try await userManager.fetchCurrentUser()
                await fetchCardsAndPotentialMatches()
            } else {
                await fetchCardsAndPotentialMatches()
            }
            
            cardStackState = cardModels.isEmpty ? .empty : .hasData
        }
    }
    
    private func fetchCardsAndPotentialMatches() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchUserCards() }
            group.addTask { await self.fetchPotentialMatchIDs() }
        }
    }
    
    private func fetchUserCards() async {
        do {
            let users = try await userManager.fetchUserCards()
            self.cardModels = users.map({ .init(user: $0) })
        } catch {
            print("DEBUG: Failed to fetch swipes with error \(error.localizedDescription)")
        }
    }
    
    private func fetchPotentialMatchIDs() async {
        do {
            self.potentialMatchIDs = try await userManager.fetchPotentialMatches()
        } catch {
            print("DEBUG: Failed to fetch potential matches \(error)")
        }
    }
    
    private func removeCard(_ user: User) async throws {
        animating = true
        
        guard !cardModels.isEmpty else { return }
        guard let index = cardModels.firstIndex(where: { $0.id == user.id }) else { return }

        try await Task.sleep(nanoseconds: 500_000_000)
        cardModels.remove(at: index)
        animating = false
        
        if cardModels.isEmpty {
            cardStackState = .empty
        }
    }
    
    func likeUser(_ user: User) async throws {
        let showMatch = potentialMatchIDs.contains(user.id)
        try await removeCard(user)
        
        if showMatch {
            matchedUser = user
        }
        
        animating = false
    }
    
    func rejectUser(_ user: User) async throws {
        try await removeCard(user)
    }
}
