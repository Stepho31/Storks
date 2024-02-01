//
//  GenderType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

enum GenderType: Int, CaseIterable, Codable {
    case man
    case woman
    case other
}

extension GenderType: Identifiable {
    var id: Int { return self.rawValue }
}

extension GenderType: CustomStringConvertible {
    var description: String {
        switch self {
        case .man:
            return "Man"
        case .woman:
            return "Woman"
        case .other:
            return "Other"
        }
    }
}
