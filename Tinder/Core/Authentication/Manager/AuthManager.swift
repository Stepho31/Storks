//
//  AuthManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import Firebase

@MainActor
class AuthManager: ObservableObject {
    @Published var authState: AuthState = .unauthenticated
    @Published var authType: AuthType?
    
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.service = service
        
        if let currentUid = Auth.auth().currentUser?.uid {
            self.authState = .authenticated(uid: currentUid)
        }
    }
    
    func authenticate(withEmail email: String, password: String) async {
        guard let authType else { return }
        
        do {
            switch authType {
            case .createAccount:
                try await createUser(withEmail: email, password: password)
            case .login:
                try await login(withEmail: email, password: password)
            }
        } catch {
            print("DEBUG: Failed to auth with error: \(error)")
        }
    }
    
    func signout() {
        service.signOut()
        self.authState = .unauthenticated
    }
    
    private func login(withEmail email: String, password: String) async throws {
        let uid = try await service.login(withEmail: email, password: password)
        self.authState = .authenticated(uid: uid)
    }
    
    private func createUser(withEmail email: String, password: String) async throws {
        let uid = try await service.createUser(withEmail: email, password: password)
        self.authState = .authenticated(uid: uid)
    }
}
