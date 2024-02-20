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
    @Published var authError: Error?
    
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
            self.authError = error
            print("DEBUG: Failed to auth with error: \(error.localizedDescription)")
        }
    }
    
    func sendResetPasswordLink(toEmail email: String) async {
        do {
            try await service.sendResetPasswordLink(toEmail: email)
        } catch {
            print("DEBUG: Failed to reset password with error: \(error)")
        }
    }
    
    func signout() {
        authType = nil
        authError = nil
        authState = .unauthenticated
        service.signOut()
    }
}

private extension AuthManager {
    func login(withEmail email: String, password: String) async throws {
        let uid = try await service.login(withEmail: email, password: password)
        authState = .authenticated(uid: uid)
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        let uid = try await service.createUser(withEmail: email, password: password)
        authState = .authenticated(uid: uid)
    }
}
