//
//  ProfileImageSize.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/11/24.
//

import Foundation

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    case xxxLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall:  return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 60
        case .xLarge: return 88
        case .xxLarge: return 120
        case .xxxLarge: return 150
        }
    }
}
