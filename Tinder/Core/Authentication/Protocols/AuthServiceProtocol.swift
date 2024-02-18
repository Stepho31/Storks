//
//  AuthServiceProtocol.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import Foundation

protocol AuthServiceProtocol {
    func createUser(withEmail email: String, password: String) async throws -> String
    func login(withEmail email: String, password: String) async throws -> String
    func sendResetPasswordLink(toEmail email: String) async throws
    func signOut()
}
