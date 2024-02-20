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
        let preferredGenders = preferredGenders(for: currentUser).map({ $0.rawValue })
        let preferredOrientations = preferredOrientations(for: currentUser).map({ $0.rawValue })
        
        do {
            try await fetchSwipes()
            
            let snapshot = try await FirestoreConstants
                .UserCollection
                .whereField("gender", in: preferredGenders)
                .whereField("sexualOrientation", in: preferredOrientations)
                .getDocuments()
            
            let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
                .filter({ filteredUser($0, currentUser: currentUser) })
            
            return users.map({.init(user: $0)})
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
    func preferredGenders(for currentUser: User) -> [GenderType] {
        let orientation = currentUser.sexualOrientation
        let gender = currentUser.gender
        
        switch orientation {
        case .gay:
            return [.man]
        case .lesbian:
            return [.woman]
        case .bisexual:
            return [.man, .woman]
        default:
            return []
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
            var result: [SexualOrientationType] = [.bisexual, .straight]
            
            if currentUser.gender == .man {
                result.append(.gay)
            } else if currentUser.gender == .woman {
                result.append(.lesbian)
            }
            
            return result
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
    
    func filteredUser(_ user: User, currentUser: User) -> Bool {
        var result = !swipedUserIDs.contains(user.id) && !user.isCurrentUser
        
        if currentUser.sexualOrientation == .bisexual {
            switch currentUser.gender {
            case .man:
                if user.gender == .man && user.sexualOrientation == .straight { return false }
            case .woman:
                if user.gender == .woman && user.sexualOrientation == .straight { return false }
            }
        }
        
        return result
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
