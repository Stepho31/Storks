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
        return DeveloperPreview.users.first(where: { $0.id == uid }) ?? DeveloperPreview.users[0]
    }
    
    func fetchUsers(for currentUser: User) async throws -> [User] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return DeveloperPreview.users
    }
}
