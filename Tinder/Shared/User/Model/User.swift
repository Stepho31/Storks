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
    let major: String
    let graduationYear: Int
    var gender: GenderType
    let sexualOrientation: SexualOrientationType
    let sexualPreference: SexualPreferenceType
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
