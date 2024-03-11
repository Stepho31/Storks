//
//  OnboardingFlowModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/28/24.
//

import Foundation

enum OnboardingSteps: Int, CaseIterable {
    case name
    case birthday
    case occupation
    case gender
    case sexualOrientation
    case photos
}

extension OnboardingSteps: Identifiable, Hashable {
    var id: Int { return self.rawValue }
}
