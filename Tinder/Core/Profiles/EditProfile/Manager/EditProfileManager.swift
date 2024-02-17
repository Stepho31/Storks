//
//  EditProfileManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import UIKit

class EditProfileManager: ObservableObject {
    
    private let service: EditProfileService
    private let imageUploader = ImageUploader()
        
    init(service: EditProfileService) {
        self.service = service
    }
    
    func saveUserData(_ user: User) async {
        do {
            try await service.saveUserData(user)
        } catch {
            print("DEBUG: Failed to save user data with error: \(error)")
        }
    }
    
    func uploadProfileImage(_ image: UIImage) async throws -> String {
        do {
            return try await imageUploader.uploadImage(image: image)
        } catch {
            print("DEBUG: Failed to upload image with error: \(error)")
            throw error
        }
    }
}
