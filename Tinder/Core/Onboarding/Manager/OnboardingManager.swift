//
//  OnboardingManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/28/24.
//

import UIKit

class OnboardingManager: ObservableObject {
    @Published var navigationPath = [OnboardingSteps]()
    @Published var didCompleteOnboarding = false
    private var currentStep: OnboardingSteps?
    
    var name = ""
    var birthday = Date()
    var study = ""
    var graduationYear = Calendar.current.component(.year, from: Date())
    var gender: GenderType?
    var sexualOrientation: SexualOrientationType?
    var profilePhotos = [UIImage]()
    
    func start() {
        guard let initialStep = OnboardingSteps(rawValue: 0) else { return }
        navigationPath.append(initialStep)
    }
    
    func navigate() {
        self.currentStep = navigationPath.last
        
        guard let index = currentStep?.rawValue else { return }
        guard let nextStep = OnboardingSteps(rawValue: index + 1) else {
            didCompleteOnboarding = true 
            return
        }
        
        navigationPath.append(nextStep)
    }
}
