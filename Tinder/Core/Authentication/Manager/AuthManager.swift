//
//  AuthManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import Foundation

@MainActor
class AuthManager: ObservableObject {
    @Published var userSessionId: String?
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
        self.userSessionId = NSUUID().uuidString
    }
    
    func login(withEmail email: String, password: String) async throws {
        self.userSessionId = try await service.login(withEmail: email, password: password)
    }
    
    func createUser(withEmail email: String, password: String, fullname: String, age: Int) async throws {
        self.userSessionId = try await service.createUser(withEmail: email, password: password, fullname: fullname, age: age)
    }
    
    func signout() {
        service.signOut()
        self.userSessionId = nil
    }
}
