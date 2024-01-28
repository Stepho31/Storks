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
    @Published var authType: AuthenticationType?
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
//        self.userSessionId = NSUUID().uuidString
    }
    
    func authenticate(withEmail email: String, password: String) async throws {
        guard let authType else { return }
        
        switch authType {
        case .createAccount:
            try await createUser(withEmail: email, password: password)
        case .login:
            try await login(withEmail: email, password: password)
        }
    }
    
    private func login(withEmail email: String, password: String) async throws {
        self.userSessionId = try await service.login(withEmail: email, password: password)
    }
    
    private func createUser(withEmail email: String, password: String) async throws {
        self.userSessionId = try await service.createUser(withEmail: email, password: password)
    }
    
    func signout() {
        service.signOut()
        self.userSessionId = nil
    }
}
