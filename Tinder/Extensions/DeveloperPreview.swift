//
//  DeveloperPreview.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import Foundation
import Firebase

struct DeveloperPreview {
    
    // MARK: - Users
    
    static let user = User(
        id: "123",
        fullname: "David Beckham",
        email: "david@gmail.com",
        age: 42,
        profileImageURLs: ["david-beckham-1", "david-beckham-2"],
        bio: "Ex-Footballer | Entreprenuer",
        occupation: "Business Man",
        gender: .man,
        sexualOrientation: .straight, 
        numberOfChildren: 1,
        blockedUIDs: [],
        blockedByUIDs: [],
        didCompleteOnboarding: true
    )
    
    static let users: [User] = [
        .init(
            id: "123",
            fullname: "David Beckham",
            email: "david@gmail.com",
            age: 42,
            profileImageURLs: ["david-beckham-1", "david-beckham-2"],
            bio: "Ex-Footballer | Entreprenuer",
            occupation: "Business Man",
            gender: .man,
            sexualOrientation: .straight, 
            numberOfChildren: 2,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        ),
        .init(
            id: "456",
            fullname: "Conor Mcgregor",
            email: "conor@gmail.com",
            age: 35,
            profileImageURLs: ["conor-mcgregor-1", "conor-mcgregor-2, conor-mcgregor-3"],
            bio: "UFC Champ Champ",
            occupation: "Pro Fighter | CEO Proper 12",
            gender: .man,
            sexualOrientation: .straight,
            numberOfChildren: 3,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        ),
        .init(
            id: "abc",
            fullname: "Jane Doe",
            email: "jane@gmail.com",
            age: 22,
            profileImageURLs: ["jane1", "jane2", "jane3"],
            bio: "Fashion Designer",
            occupation: "Designer",
            gender: .woman,
            sexualOrientation: .straight,
            numberOfChildren: 9,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        ),
        .init(
            id: "def",
            fullname: "Kelly Johnson",
            email: "kelly@gmail.com",
            age: 21,
            profileImageURLs: ["kelly1", "kelly2", "kelly3"],
            bio: "Social media influencer",
            occupation: "Entertainment",
            gender: .woman,
            sexualOrientation: .straight, 
            numberOfChildren: 6,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        ),
        .init(
            id: "xyz",
            fullname: "Megan Fox",
            email: "megan@gmail.com",
            age: 37,
            profileImageURLs: ["megan-fox-1", "megan-fox-2"],
            bio: "Actress | Witch",
            occupation: "Entertainment",
            gender: .woman,
            sexualOrientation: .straight,
            numberOfChildren: 5,
            blockedUIDs: [],
            blockedByUIDs: [],
            didCompleteOnboarding: true
        )
    ]
}

// MARK: - Cards

extension DeveloperPreview {
    static let cards: [CardModel] = users.map({ .init(user: $0) })
}

// MARK: - Chats

extension DeveloperPreview {
    static let message = ChatMessage(
        id: NSUUID().uuidString,
        fromId: users[0].id,
        toId: users[4].id,
        text: "Hello there!",
        timestamp: Timestamp(),
        read: false,
        user: user
    )
    
    static var messages: [ChatMessage] = [
        .init(
            id: NSUUID().uuidString,
            fromId: users[0].id,
            toId: users[4].id,
            text: "This is a test message for preview purposes! Let's see what",
            timestamp: Timestamp(),
            read: false,
            user: users[4]
        ),
        .init(
            id: NSUUID().uuidString,
            fromId: users[0].id,
            toId: users[4].id,
            text: "Second test message goes here",
            timestamp: Timestamp(),
            read: false,
            user: users[4]
        ),
        .init(
            id: NSUUID().uuidString,
            fromId: "123",
            toId: "456",
            text: "This is yet another test message for preview purposes",
            timestamp: Timestamp(),
            read: false,
            user: users[1]
        ),
        .init(
            id: NSUUID().uuidString,
            fromId: "456",
            toId: "123",
            text: "Hello World! Welcome to the best dating app ever",
            timestamp: Timestamp(),
            read: false,
            user: users[0]
        ),
    ]
    
    static var thread = Thread(
        id: NSUUID().uuidString,
        uids: [users[0].id, users[4].id],
        lastMessage: messages[0],
        lastUpdated: Timestamp(),
        chatPartner: users[4]
    )
    
    static var threads: [Thread] = [
        .init(
            id: NSUUID().uuidString,
            uids: [users[0].id, users[4].id],
            lastMessage: messages[0],
            lastUpdated: Timestamp(),
            chatPartner: users[4]
        )
    ]
}

// MARK: - Matches

extension DeveloperPreview {
    static let matches: [Match] = [
        .init(id: NSUUID().uuidString, userId: users[3].id, matchTimestamp: Timestamp(), user: users[3]),
        .init(id: NSUUID().uuidString, userId: users[4].id, matchTimestamp: Timestamp(), user: users[4]),
    ]
}
