//
//  OnboardingService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/20/24.
//

import Firebase

struct OnboardingService {
    
    private let imageUploader: ImageUploader
    
    init(imageUploader: ImageUploader) {
        self.imageUploader = imageUploader
    }
    
    func uploadUserData(_ user: User, profilePhotos: [UIImage]) async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        var result = user
        
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UserCollection.document(uid).setData(userData)
            let imageURLs = try await uploadUserPhotos(profilePhotos)
            result.profileImageURLs.append(contentsOf: imageURLs)
            return result
        } catch {
            throw error
        }
    }
    
    func uploadUserPhotos(_ photos: [UIImage]) async throws -> [String] {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        
        return try await withThrowingTaskGroup(of: String.self) { group in
            var result = [String]()
            
            for photo in photos {
                group.addTask { return try await self.imageUploader.uploadImage(image: photo) }
            }
            
            for try await imageUrl in group {
                result.append(imageUrl)
                try await FirestoreConstants.UserCollection.document(uid).updateData([
                    "profileImageURLs": FieldValue.arrayUnion([imageUrl])
                ])
            }
            
            return result
        }
    }
}
