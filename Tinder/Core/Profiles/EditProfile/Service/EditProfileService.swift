//
//  EditProfileService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/5/24.
//

import Firebase

struct EditProfileService {
    
    func saveUserData(_ user: User) async throws{
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UserCollection.document(user.id).setData(userData)
        } catch {
            throw error
        }
    }
}
