//
//  SearchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/3/24.
//

import Foundation

protocol SearchServiceProtocol {
    func fetchUsers() async throws -> [User]
}

struct SearchService: SearchServiceProtocol {
    func fetchUsers() async throws -> [User] {
        let snapshot = try await FirestoreConstants.UserCollection.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
}
