//
//  UserProfileSheetConfiguration.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import Foundation

enum UserProfileSheetConfiguration {
    case block
    case report 
}

extension UserProfileSheetConfiguration: Identifiable {
    var id: Int { return self.hashValue }
}
