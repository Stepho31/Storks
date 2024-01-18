//
//  AuthService.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import Firebase

struct AuthService: AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String? {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return result.user.uid
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String, age: Int) async throws -> String? {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await uploadUserData(email: email, fullname: fullname, age: age, id: result.user.uid)
            return result.user.uid
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
            throw error
        }
    }
    
    private func uploadUserData(email: String, fullname: String, age: Int, id: String) async throws {
//        let user = User(id: id, fullname: fullname, email: email, age: age, profileImageURLs: [])
//        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
//        try await FirestoreConstants.UserCollection.document(id).setData(encodedUser)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    func sendPasswordResetEmail(toEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Failed to send email with error \(error.localizedDescription)")
        }
    }
}
