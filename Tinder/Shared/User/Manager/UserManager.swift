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
        
        do {
            currentUser = try await service.fetchUser(withUid: currentUid)
        } catch {
            print("DEBUG: Failed to fetch current user with error: \(error)")
        }
    }
    
    func uploadUserData(_ user: User, profilePhotos: [UIImage]) async {
        do {
            self.currentUser = try await service.uploadUserData(user, profilePhotos: profilePhotos)
        } catch {
            print("DEBUG: Failed to upload user data with error: \(error.localizedDescription)")
        }
    }
}
