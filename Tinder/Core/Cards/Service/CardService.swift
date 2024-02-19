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
    private var swipes = [SwipeModel]()
    
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        let preferredGender = preferredGender(for: currentUser)
        let preferredOrientations = preferredOrientations(for: currentUser).map({ $0.rawValue })
        
        do {
            try await fetchSwipes()
            
            let snapshot = try await FirestoreConstants
                .UserCollection
                .whereField("gender", isEqualTo: preferredGender.rawValue)
                .whereField("sexualOrientation", in: preferredOrientations)
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
        let rejectedUIDs = swipes.filter({ $0.didLike == .reject }).map({ $0.uid })
                
        for uid in rejectedUIDs {
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

        let swipeModel = SwipeModel(didLike: swipe, uid: user.id)
        let swipeData = try Firestore.Encoder().encode(swipeModel)
        
        try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-swipes")
            .document(user.id)
            .setData(swipeData)
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
    
    func preferredOrientations(for currentUser: User) -> [SexualOrientationType] {
        let orientation = currentUser.sexualOrientation
        
        switch orientation {
        case .straight:
            return [.straight]
        case .gay:
            return [.gay, .bisexual]
        case .lesbian:
            return [.lesbian, .bisexual]
        case .bisexual:
            return [.straight, .bisexual]
        case .asexual:
            return [.asexual]
        case .demisexual:
            return [.demisexual]
        case .pansexual:
            return [.pansexual]
        case .queer:
            return [.queer]
        case .questioning:
            return [.questioning]
        }

    }
    
    func fetchSwipes() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(currentUid)
            .collection("user-swipes")
            .getDocuments()
        
        self.swipes = snapshot.documents.compactMap({ try? $0.data(as: SwipeModel.self) })
        self.swipedUserIDs = snapshot.documents.map({ $0.documentID })
    }
}
