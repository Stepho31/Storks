//
//  MockUserService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import UIKit

struct MockUserService: UserServiceProtocol {
    func fetchUser(withUid uid: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return DeveloperPreview.user
    }
    
    func fetchUsers(for currentUser: User) async throws -> [User] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let sexualPreference = currentUser.sexualPreference
        return DeveloperPreview.users.filter({ $0.gender == sexualPreference.preferredGender })
    }
    
    func uploadUserData(_ user: User, profilePhotos: [UIImage]) async throws -> User {
        return DeveloperPreview.user
    }
}
