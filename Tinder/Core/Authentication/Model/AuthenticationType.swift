//
//  AuthenticationType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/27/24.
//

import Foundation

enum AuthenticationType {
    case createAccount
    case login
}

extension AuthenticationType: Identifiable {
    var id: String { return NSUUID().uuidString }
}
