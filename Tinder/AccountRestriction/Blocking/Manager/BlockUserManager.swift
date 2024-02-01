//
//  BlockUserManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/1/24.
//

import Foundation

class BlockUserManager: ObservableObject {
    
    private let service: BlockUserService
    
    init(service: BlockUserService) {
        self.service = service
    }
    
    func blockUser(_ user: User) async {
        do {
            try await service.blockUser(user)
        } catch {
            print("DEBUG: Failed to block user with error: \(error)")
        }
    }
    
}
