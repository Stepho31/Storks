//
//  CardService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Firebase

protocol CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel]
    func saveSwipe(forUser user: User, swipe: SwipeAction) async throws
    func resetCards(for currentUser: User) async throws
}

class CardService: CardServiceProtocol {
    private var swipedUserIDs = [String]()
    private var rejectedUserIDs = [String]()
    
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        let preferredGender = preferredGender(for: currentUser)

        do {
            try await fetchSwipes()
            
            let snapshot = try await FirestoreConstants
                .UserCollection
                .whereField("gender", isEqualTo: preferredGender.rawValue)
                .whereField("sexualOrientation", isEqualTo: currentUser.sexualOrientation.rawValue)
                .getDocuments()
            
            let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
            return users.map({ .init(user: $0) }).filter({ !swipedUserIDs.contains($0.user.id) })
        } catch {
            print("DEBUG: Failed to fetch cards with error: \(error)")
            throw error
        }
    }
    
    func resetCards(for currentUser: User) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        for uid in swipedUserIDs {
            try await FirestoreConstants
                .UserCollection
                .document(currentUid)
                .collection("user-swipes")
                .document(uid)
                .delete()
        }
    }
        
    func saveSwipe(forUser user: User, swipe: SwipeAction) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-swipes")
            .document(user.id)
            .setData(["didLike": swipe.rawValue])
    }
}

private extension CardService {
    func preferredGender(for currentUser: User) -> GenderType {
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
    
    func fetchSwipes() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-swipes")
            .getDocuments()
        
        self.swipedUserIDs = snapshot.documents.map({ $0.documentID })
        
        for doc in snapshot.documents {
            let data = doc.data()
        }
    }
}
