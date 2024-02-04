//
//  CardService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase

protocol CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel]
    func saveLike(forUser user: User) async throws
}

struct CardService: CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        let genderToFetch = genderToFetch(for: currentUser)
        
        do {
            let snapshot = try await FirestoreConstants
                .UserCollection
                .whereField("gender", isEqualTo: genderToFetch.rawValue)
                .getDocuments()
            
            let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
            return users.map({ .init(user: $0) })
        } catch {
            print("DEBUG: Failed to fetch cards with error: \(error)")
            throw error
        }
    }
    
    func saveLike(forUser user: User) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-likes")
            .document(user.id)
            .setData([:])
    }
    
    private func genderToFetch(for currentUser: User) -> GenderType {
        let orientation = currentUser.sexualOrientation
        let gender = currentUser.gender
        
        switch orientation {
        case .straight:
            return gender == .man ? .woman : .man
        case .gay:
            return .man
        case .lesbian:
            return .woman
        default:
            return .other
        }
    }
}
