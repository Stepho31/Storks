//
//  User.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import FirebaseFirestoreSwift
import Firebase
import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    var age: Int
    var profileImageURLs: [String]
    var bio: String?
    let occupation: String
    var gender: GenderType
    let sexualOrientation: SexualOrientationType
    var numberOfChildren: Int
    var relationshipGoals: RelationshipGoalsType?
    // Subscription plan (nil decodes to Free for legacy users)
    var plan: SubscriptionPlan? = nil
    // Lifestyle and safety extensions
    var parentingStyle: ParentingStyleType? = nil
    var familyValues: [FamilyValueType]? = nil
    var availabilityPresets: [AvailabilityPreset]? = nil
    var storyPromptAnswers: [StoryPromptAnswer]? = nil
    var isParentVerified: Bool? = nil
    var blockedUIDs: [String]
    var blockedByUIDs: [String]
    var didCompleteOnboarding: Bool
    
    var isCurrentUser: Bool {
        return id == Auth.auth().currentUser?.uid
    }
    
    var firstName: String {
        let components = fullname.components(separatedBy: " ")
        return components[0]
    }
    
    var numberOfImages: Int {
        return profileImageURLs.count
    }
}

extension User {
    func preferredGenders(for currentUser: User) -> [GenderType] {
        let orientation = currentUser.sexualOrientation
        let gender = currentUser.gender
        
        switch orientation {
        case .gay:
            return [.man]
        case .lesbian:
            return [.woman]
        case .bisexual:
            return [.man, .woman]
        case .straight:
            return gender == .man ? [.woman] : [.man]
        default:
            return [.man, .woman]
        }
    }
    
    func preferredOrientations(for currentUser: User) -> [SexualOrientationType] {
        let orientation = currentUser.sexualOrientation
        let gender = currentUser.gender
        
        switch orientation {
        case .straight:
            return [.straight, .bisexual]
        case .gay:
            return [.gay, .bisexual]
        case .lesbian:
            return [.lesbian, .bisexual]
        case .bisexual:
            var result: [SexualOrientationType] = [.bisexual, .straight]
            
            if currentUser.gender == .man {
                result.append(.gay)
            } else if currentUser.gender == .woman {
                result.append(.lesbian)
            }
            
            return result
        case .asexual:
            return [.asexual]
        case .demisexual:
            return [.demisexual]
        case .pansexual:
            return [.pansexual]
        case .queer:
            return [.queer]
        case .questioning:
            return [.questioning]
        }
    }
}

// MARK: - Lifestyle Types

/// High-level parenting style taxonomy. Expandable as we learn from users.
enum ParentingStyleType: Int, Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case authoritative
    case gentle
    case structured
    case flexible
    case collaborative

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .authoritative: return "Authoritative"
        case .gentle: return "Gentle"
        case .structured: return "Structured"
        case .flexible: return "Flexible"
        case .collaborative: return "Collaborative"
        }
    }
}

/// Core family values that influence compatibility beyond romance.
enum FamilyValueType: Int, Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case communication
    case education
    case adventure
    case tradition
    case wellness
    case community

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .communication: return "Open communication"
        case .education: return "Education"
        case .adventure: return "Adventure"
        case .tradition: return "Tradition"
        case .wellness: return "Health & wellness"
        case .community: return "Community involvement"
        }
    }
}

/// Coarse-grained availability presets designed for easy onboarding and planning.
enum AvailabilityPreset: Int, Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case weekdayDay
    case weekdayEvening
    case weekendDay
    case weekendEvening
    case lateNight

    var id: Int { rawValue }

    var description: String {
        switch self {
        case .weekdayDay: return "Weekday day"
        case .weekdayEvening: return "Weekday evening"
        case .weekendDay: return "Weekend day"
        case .weekendEvening: return "Weekend evening"
        case .lateNight: return "Late night"
        }
    }
}

/// Lightweight, story-based prompts to warm profiles.
struct StoryPromptAnswer: Codable, Hashable, Identifiable {
    let id: String
    let prompt: String
    var answer: String
}
