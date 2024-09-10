//
//  AuthenticationType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/27/24.
//

import Foundation

enum AuthType {
    case createAccount
    case login
}

extension AuthType: Identifiable {
    var id: String { return NSUUID().uuidString }
}
