//
//  EditProfileManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import UIKit

class EditProfileManager: ObservableObject {
    
    private let service: EditProfileService
        
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
    
    func deletePhoto(_ imageUrl: String) async {
        do {
            try await service.deletePhoto(imageUrl)
        } catch {
            print("DEBUG: Failed to delete photo with error: \(error)")
        }
    }
}
