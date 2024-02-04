//
//  FirestoreConstants.swift
//  Tinder
//
//  Created by Stephan Dowless on 8/8/23.
//

import Firebase

struct FirestoreConstants {
    private static let Root = Firestore.firestore()
    
    static let UserCollection = Root.collection("users")
    static let ThreadsCollection = Root.collection("threads")
    
    static func MatchesCollection(uid: String) -> CollectionReference {
        return UserCollection.document(uid).collection("user-matches")
    }
    
    static func UserLikesCollection(uid: String) -> CollectionReference {
        return UserCollection.document(uid).collection("user-likes")
    }
}
