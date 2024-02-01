//
//  AuthServiceProtocol.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import Foundation

protocol AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String
    func createUser(withEmail email: String, password: String) async throws -> String
    func signOut()
}
