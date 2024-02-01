//
//  EditProfileSheetConfiguration.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

enum EditProfileSheetConfiguration: Identifiable {
    case relationshipGoals
    case gender
    case sexualOrientation
    
    var id: Int {
        return self.hashValue
    }
}
