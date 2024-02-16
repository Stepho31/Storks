//
//  OnboardingManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/28/24.
//

import UIKit
import Firebase

class OnboardingManager: ObservableObject {
    @Published var navigationPath = [OnboardingSteps]()
    @Published var user: User?
    @Published var name = ""
    @Published var study = ""
    @Published var profilePhotos = [UIImage]()

    var birthday = Date()
    var graduationYear = Calendar.current.component(.year, from: Date())
    var gender: GenderType?
    var sexualOrientation: SexualOrientationType?
    
    private var currentStep: OnboardingSteps?
    
    func start() {
        guard let initialStep = OnboardingSteps(rawValue: 0) else { return }
        navigationPath.append(initialStep)
    }
    
    func navigate() {
        self.currentStep = navigationPath.last
        
        guard let index = currentStep?.rawValue else { return }
        guard let nextStep = OnboardingSteps(rawValue: index + 1) else {
            createUser()
            return
        }
        
        navigationPath.append(nextStep)
    }
    
    func createUser() {
        guard let gender else { return }
        guard let sexualOrientation else { return }
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let email = Auth.auth().currentUser?.email else { return }
                
        let ageComponents = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        let age = ageComponents.year!
        
        self.user = User(
            id: id,
            fullname: name,
            email: email,
            age: age,
            profileImageURLs: [],
            major: study,
            graduationYear: graduationYear,
            gender: gender,
            sexualOrientation: sexualOrientation,
            sexualPreference: .women,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        )
    }
}
