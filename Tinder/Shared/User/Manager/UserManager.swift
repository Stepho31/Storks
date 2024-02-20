//
//  UserManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/13/24.
//

import Firebase
import SwiftUI

@MainActor
class UserManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoading = false
    
    private let service: UserServiceProtocol
    private let imageUploader: ImageUploader
    
    private var currentUid: String? {
        return Auth.auth().currentUser?.uid
    }
        
    init(service: UserServiceProtocol) {
        self.service = service
        self.imageUploader = ImageUploader()
        
        Task { await fetchCurrentUser() }
    }
        
    func fetchCurrentUser() async {
        guard let currentUid else { return }
        isLoading = true
        
        do {
            currentUser = try await service.fetchUser(withUid: currentUid)
            isLoading = false
        } catch {
            print("DEBUG: Failed to fetch current user with error: \(error)")
            isLoading = false 
        }
    }    
}
