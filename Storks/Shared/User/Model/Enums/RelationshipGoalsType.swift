//
//  RelationshipGoalsType.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import Foundation
//
//enum RelationshipGoalsType: Int, CaseIterable {
//    case longTermPartner
//    case longTermOpenToShort
//    case shortTermOpenToLong
//    case shortTermFun
//    case newFriends
//    case stillFiguringOut
//}

enum RelationshipGoalsType: Int, Codable, CaseIterable {
    case longTermPartner = 0
    case longTermOpenToShort = 1
    case shortTermOpenToLong = 2
    case shortTermFun = 3
    case newFriends = 4
    case stillFiguringOut = 5
}

extension RelationshipGoalsType: Identifiable {
    var id: Int { return self.rawValue }
}

extension RelationshipGoalsType: CustomStringConvertible {
    var description: String {
        switch self {
        case .longTermPartner:
            return "Long-term partner"
        case .longTermOpenToShort:
            return "Long-term, open to short"
        case .shortTermOpenToLong:
            return "Short-term, open to long"
        case .shortTermFun:
            return "Short-term fun"
        case .newFriends:
            return "New friends"
        case .stillFiguringOut:
            return "Still figuring it out"
        }
    }
    
    var emoji: String {
        switch self {
        case .longTermPartner:
            return "💘"
        case .longTermOpenToShort:
            return "😍"
        case .shortTermOpenToLong:
            return "🥂"
        case .shortTermFun:
            return "🥳"
        case .newFriends:
            return "👋"
        case .stillFiguringOut:
            return "🤔"
        }
    }
    
    var fullDescription: String {
        return "\(emoji) \(description)"
    }
}
