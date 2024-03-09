//
//  MockSearchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 3/5/24.
//

import Foundation

struct MockSearchService: SearchServiceProtocol {
    func fetchUsers() async throws -> [User] {
        return DeveloperPreview.users
    }
}
