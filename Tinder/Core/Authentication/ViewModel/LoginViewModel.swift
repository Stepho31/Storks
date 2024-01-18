//
//  LoginViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private let manager: AuthManager
    
    init(manager: AuthManager) {
        self.manager = manager
    }
    
    func login() async throws {
        try await manager.login(withEmail: email, password: password)
    }
}
