//
//  AuthState.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/29/24.
//

import Foundation

enum AuthState {
    case unauthenticated
    case authenticated(uid: String)
}
