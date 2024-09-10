//
//  SexualOrientationType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

enum SexualOrientationType: Int, CaseIterable, Codable {
    case straight
    case gay
    case lesbian
    case bisexual
    case asexual
    case demisexual
    case pansexual
    case queer
    case questioning
}

extension SexualOrientationType: Identifiable {
    var id: Int { return self.rawValue }
}

extension SexualOrientationType: CustomStringConvertible {
    var description: String {
        switch self {
        case .straight:
            return "Straight"
        case .gay:
            return "Gay"
        case .lesbian:
            return "Lesbian"
        case .bisexual:
            return "Bisexual"
        case .asexual:
            return "Asexual"
        case .demisexual:
            return "Demisexual"
        case .pansexual:
            return "Pansexual"
        case .queer:
            return "Queer"
        case .questioning:
            return "Questioning"
        }
    }
}
