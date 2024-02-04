//
//  SearchViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/3/24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    private let service: SearchServiceProtocol
    
    init(service: SearchServiceProtocol) {
        self.service = service
        
        Task { await fetchUsers() }
    }
    
    func fetchUsers() async {
        do {
            self.users = try await service.fetchUsers()
        } catch {
            print("DEBUG: Failed to fetch users with error: \(error)")
        }
    }
}
