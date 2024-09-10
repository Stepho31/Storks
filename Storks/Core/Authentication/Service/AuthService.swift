//
//  AuthService.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import Firebase

struct AuthService: AuthServiceProtocol {
    func login(withEmail email: String, password: String) async throws -> String {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return result.user.uid
        } catch {
            print("DEBUG: Failed to login with error \(error)")
            throw error
        }
    }
    
    func createUser(withEmail email: String, password: String) async throws -> String {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return result.user.uid
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func deleteAccount() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        try await deleteThreads(currentUid)
        try await deleteMatches(currentUid)
        try await FirestoreConstants.UserCollection.document(currentUid).delete()
        try await Auth.auth().currentUser?.delete()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    func sendResetPasswordLink(toEmail email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Failed to send email with error \(error.localizedDescription)")
        }
    }
}

private extension AuthService {
    func deleteThreads(_ currentUid: String) async throws {
        let threadsSnapshot = try await FirestoreConstants
            .ThreadsCollection
            .whereField("uids", arrayContains: currentUid)
            .getDocuments()
        
        for doc in threadsSnapshot.documents {
            try await FirestoreConstants
                .ThreadsCollection
                .document(doc.documentID)
                .delete()
        }
    }
    
    func deleteMatches(_ currentUid: String) async throws {
        let matchesSnapshot = try await FirestoreConstants
            .MatchesCollection(uid: currentUid)
            .getDocuments()
        
        let matches = matchesSnapshot.documents.compactMap({ try? $0.data(as: Match.self) })
        
        for match in matches {
            try await FirestoreConstants
                .MatchesCollection(uid: match.userId)
                .document(match.id)
                .delete()
        }
    }
}
