//
//  String+Password.swift
//  Tinder
//
//  Created by Brandon on 1/27/24.
//

import Foundation

extension String {
    func isValidPassword(password: String) -> Bool {
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
}
