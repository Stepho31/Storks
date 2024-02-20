//
//  EditProfileService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import Firebase
import FirebaseStorage

struct EditProfileService {
    
    private let imageUploader = ImageUploader()
    
    func saveUserData(_ user: User) async throws {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UserCollection.document(user.id).setData(userData)
        } catch {
            throw error
        }
    }
    
    func deletePhoto(_ imageUrl: String) async throws {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await deletePhotoFromStorage(imageUrl) }
            group.addTask { try await updateUserImageURLs(imageUrl) }
        }
    }
    
    func uploadUserPhoto(_ photo: UIImage) async throws -> String {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        let imageUrl = try await self.imageUploader.uploadImage(image: photo)
        
        try await FirestoreConstants.UserCollection.document(uid).updateData([
            "profileImageURLs": FieldValue.arrayUnion([imageUrl])
        ])
        
        return imageUrl
    }
    
    private func deletePhotoFromStorage(_ imageUrl: String) async throws {
        try await Storage.storage().reference(withPath: imageUrl).delete()
    }
    
    private func updateUserImageURLs(_ imageUrl: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        try await FirestoreConstants.UserCollection.document(uid).updateData([
            "profileImageURLs": FieldValue.arrayRemove([imageUrl])
        ])
    }
}
