//
//  SexualPreferenceType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/13/24.
//

import Foundation

enum SexualPreferenceType: Int, CaseIterable, Codable {
    case men
    case women
    case everyone
}

extension SexualPreferenceType {
    var preferredGender: GenderType {
        switch self {
        case .men:
            return .man
        case .women:
            return .woman
        case .everyone:
            return .other
        }
    }
}

extension SexualPreferenceType: Identifiable {
    var id: Int { return self.rawValue }
}

extension SexualPreferenceType: CustomStringConvertible {
    var description: String {
        switch self {
        case .men:
            return "Men"
        case .women:
            return "Women"
        case .everyone:
            return "Everyone"
        }
    }
}

