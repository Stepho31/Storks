//
//  UserManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/13/24.
//

import Firebase
import SwiftUI

class UserManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var currentUser: User?
    @Published var didCompleteOnboarding = true
    
    private let service: UserServiceProtocol
    
    private var currentUid: String? {
        guard let uid = Auth.auth().currentUser?.uid else { return "123" }
        return uid
    }
    
    // MARK: - Lifecycle
    
    init(service: UserServiceProtocol) {
        self.service = service
        
        Task { try await fetchCurrentUser() }
    }
    
    // MARK: - API
    
    @MainActor
    func fetchCurrentUser() async throws -> User? {
        if let currentUser {
            return currentUser
        }
        
        guard let currentUid else { return nil }
        
        do {
            currentUser = try await service.fetchUser(withUid: currentUid)
            return currentUser
        } catch {
            throw error
        }
    }
    
    func fetchUserCards() async throws -> [User] {
        guard let currentUser else { return [] }
        
        do {
            return try await service.fetchUsers(for: currentUser)
        } catch {
            print("DEBUG: Failed to fetch swipes with error \(error)")
            throw error
        }
    }
    
    func fetchPotentialMatches() async throws -> [String] {
        return ["abc"]
    }
}
