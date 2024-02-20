//
//  OnboardingManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/28/24.
//

import UIKit
import Firebase

@MainActor
class OnboardingManager: ObservableObject {
    @Published var navigationPath = [OnboardingSteps]()
    @Published var name = ""
    @Published var study = ""
    @Published var profilePhotos = [UIImage]()
    @Published var user: User?
    @Published var uploadingUserData = false

    var birthday = Date()
    var graduationYear = Calendar.current.component(.year, from: Date())
    var gender: GenderType?
    var sexualOrientation: SexualOrientationType?
    
    private let service: OnboardingService
    private var currentStep: OnboardingSteps?
    
    init(service: OnboardingService) {
        self.service = service
    }
    
    func start() {
        guard let initialStep = OnboardingSteps(rawValue: 0) else { return }
        navigationPath.append(initialStep)
    }
    
    func navigate() {
        self.currentStep = navigationPath.last
        
        guard let index = currentStep?.rawValue else { return }
        guard let nextStep = OnboardingSteps(rawValue: index + 1) else {
            Task { await uploadUserData() }
            return
        }
        
        navigationPath.append(nextStep)
    }
    
    func uploadUserData() async {
        guard let user = createUser() else { return }
        uploadingUserData = true
        navigationPath.removeAll()
        
        do {
            self.user = try await service.uploadUserData(user, profilePhotos: profilePhotos)
            uploadingUserData = false
        } catch {
            print("DEBUG: Failed to upload user data with error: \(error.localizedDescription)")
            uploadingUserData = false
        }
    }
}

private extension OnboardingManager {
    func createUser() -> User? {
        guard let gender else { return nil }
        guard let sexualOrientation else { return nil }
        guard let id = Auth.auth().currentUser?.uid else { return nil }
        guard let email = Auth.auth().currentUser?.email else { return nil }
        
        let ageComponents = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        let age = ageComponents.year!
        
        return User(
            id: id,
            fullname: name,
            email: email,
            age: age,
            profileImageURLs: [],
            major: study,
            graduationYear: graduationYear,
            gender: gender,
            sexualOrientation: sexualOrientation,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        )
    }
}
