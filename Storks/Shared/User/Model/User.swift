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
