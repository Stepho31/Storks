//
//  CardsViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import Foundation

@MainActor
class CardsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var animatedSwipeAction: SwipeAction?
    @Published var animating = false
    @Published var cardStackState: CardStackState = .empty
    
    @Published var cardModels = [CardModel]() {
        didSet { updateCardStackState() }
    }
        
    private let currentUser: User?
    private let cardService: CardServiceProtocol
    private let matchManager: MatchManager
    
    // MARK: - Lifecycle
    
    init(currentUser: User?, cardService: CardServiceProtocol, matchManager: MatchManager) {
        self.currentUser = currentUser
        self.cardService = cardService
        self.matchManager = matchManager
                
        Task { await fetchUserCards() }
    }
    
    // MARK: - Card Helpers
        
    private func removeCard(_ user: User) async throws {
        animating = true
        
        guard !cardModels.isEmpty else { return }
        guard let index = cardModels.firstIndex(where: { $0.id == user.id }) else { return }

        try await Task.sleep(nanoseconds: 500_000_000)
        cardModels.remove(at: index)
        animating = false
    }
    
    func likeUser(_ user: User) async {
        do {
            try await removeCard(user)
            try await cardService.saveLike(forUser: user)
            await matchManager.checkForMatch(fromUser: user, currentUser: currentUser)
        } catch {
            print("DEBUG: Like user failed with error: \(error)")
        }
    }
    
    func rejectUser(_ user: User) async throws {
        try await removeCard(user)
    }
    
    func updateCardStackState() {
        cardStackState = cardModels.isEmpty ? .empty : .hasData(cardModels)
    }
}

// MARK: - API
// TODO: Extract to manager class?

private extension CardsViewModel {
    func fetchUserCards() async {
        guard let currentUser else { return }
        cardStackState = .loading
        
        do {
            self.cardModels = try await cardService.fetchCards(for: currentUser)
            cardStackState = cardModels.isEmpty ? .empty : .hasData(cardModels)
        } catch {
            print("DEBUG: Failed to fetch cards with error \(error.localizedDescription)")
        }
    }
}
