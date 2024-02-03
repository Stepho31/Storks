//
//  AuthViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/28/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
