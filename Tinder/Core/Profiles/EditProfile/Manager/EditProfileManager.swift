//
//  EditProfileManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import Foundation


class EditProfileManager: ObservableObject {
    
    private let service: EditProfileService
    
    init(service: EditProfileService) {
        self.service = service
    }
    
    func saveUserData(_ user: User) async {
        
    }
}
