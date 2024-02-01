//
//  UserManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/13/24.
//

import Firebase
import SwiftUI

class UserManager: ObservableObject {
    @Published var currentUser: User?
    @Published var didCompleteOnboarding = true
    
    private let service: UserServiceProtocol
    
    private var currentUid: String? {
        guard let uid = Auth.auth().currentUser?.uid else { return "123" }
        return uid
    }
        
    init(service: UserServiceProtocol) {
        self.service = service
        
        Task { await fetchCurrentUser() }
    }
        
    @MainActor
    func fetchCurrentUser() async {
        guard let currentUid else { return }
        
        do {
            currentUser = try await service.fetchUser(withUid: currentUid)
        } catch {
            print("DEBUG: Failed to fetch current user with error: \(error)")
        }
    }
}
