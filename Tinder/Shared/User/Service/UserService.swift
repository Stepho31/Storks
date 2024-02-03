//
//  UserService.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func fetchUser(withUid uid: String) async throws -> User
    func fetchUsers(for currentUser: User) async throws -> [User]
    func uploadUserData(_ user: User, profilePhotos: [UIImage]) async throws -> User
}

struct UserService: UserServiceProtocol {
    private let imageUploader = ImageUploader()
    
    func fetchUser(withUid uid: String) async throws -> User {
        do {
            let snapshot = try await FirestoreConstants.UserCollection.document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            return user
        } catch {
            throw error
        }
    }
    
    func fetchUsers(for currentUser: User) async throws -> [User] {
        return []
    }
    
    func fetchUsers() async throws -> [User] {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        
        do {
            let snapshot = try await FirestoreConstants.UserCollection.getDocuments()
            let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
            return users.filter({ $0.id != uid })
        } catch {
            throw error
        }
    }
    
    func uploadUserData(_ user: User, profilePhotos: [UIImage]) async throws -> User {
        guard let uid = Auth.auth().currentUser?.uid else { throw UserError.invalidUserId }
        var result = user
        
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UserCollection.document(uid).setData(userData)
            result.profileImageURLs = try await uploadUserPhotos(profilePhotos)
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
