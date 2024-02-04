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
        fullname: "Charles Leclerc",
        email: "charles@gmail.com",
        age: 24,
        profileImageURLs: ["charles-leclerc", "lewis-hamilton"],
        bio: "Formula 1 Driver for Ferrari",
        major: "Mechanical Engineering",
        graduationYear: 2026,
        gender: .man,
        sexualOrientation: .straight,
        sexualPreference: .women,
        blockedUIDs: [],
        blockedByUIDs: []
    )
    
    static let users: [User] = [
        .init(
            id: "123",
            fullname: "Charles Leclerc",
            email: "charles@gmail.com",
            age: 24,
            profileImageURLs: ["charles-leclerc", "lewis-hamilton"],
            bio: "Formula 1 Driver for Ferrari",
            major: "Mechanical Engineering",
            graduationYear: 2026,
            gender: .man,
            sexualOrientation: .straight,
            sexualPreference: .women,
            blockedUIDs: [],
            blockedByUIDs: []
        ),
        .init(
            id: "456",
            fullname: "Lewis Hamilton",
            email: "lewis@gmail.com",
            age: 38,
            profileImageURLs: ["lewis-hamilton", "checo-perez"],
            bio: "Formula 1 Driver for Mercedes",
            major: "Aerospace Engineering",
            graduationYear: 2027,
            gender: .man,
            sexualOrientation: .straight,
            sexualPreference: .women,
            blockedUIDs: [],
            blockedByUIDs: []
        ),
        .init(
            id: "abc",
            fullname: "Jane Doe",
            email: "jane@gmail.com",
            age: 22,
            profileImageURLs: ["jane1", "jane2", "jane3"],
            bio: "Fashion Designer",
            major: "Design",
            graduationYear: 2027,
            gender: .woman,
            sexualOrientation: .straight,
            sexualPreference: .men,
            blockedUIDs: [],
            blockedByUIDs: []
        ),
        .init(
            id: "def",
            fullname: "Kelly Johnson",
            email: "kelly@gmail.com",
            age: 21,
            profileImageURLs: ["kelly1", "kelly2", "kelly3"],
            bio: "Social media influencer",
            major: "Entertainment",
            graduationYear: 2027,
            gender: .woman,
            sexualOrientation: .straight,
            sexualPreference: .men,
            blockedUIDs: [],
            blockedByUIDs: []
        )
    ]
}

// MARK: - Cards

extension DeveloperPreview {
    static let cards: [CardModel] = users.map({ .init(user: $0) })
}

// MARK: - Chats

extension DeveloperPreview {
    static let message = Message(
        id: NSUUID().uuidString,
        fromId: "123",
        toId: "456",
        text: "Hello there!",
        timestamp: Timestamp(),
        read: false,
        user: user
    )
    
    static var messages: [Message] = [
        .init(
            id: NSUUID().uuidString,
            fromId: "456",
            toId: "123",
            text: "This is a test message for preview purposes! Let's see what",
            timestamp: Timestamp(),
            read: false,
            user: users[1]
        ),
        .init(
            id: NSUUID().uuidString,
            fromId: "123",
            toId: "456",
            text: "Second test message goes here",
            timestamp: Timestamp(),
            read: false,
            user: users[0]
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
        uids: ["123", "456"],
        lastMessage: messages[0],
        lastUpdated: Timestamp(),
        chatPartner: users[0]
    )
    
    static var threads: [Thread] = [
        .init(
            id: NSUUID().uuidString,
            uids: ["123", "456"],
            lastMessage: messages[0],
            lastUpdated: Timestamp(),
            chatPartner: users[0]
        )
    ]
}

// MARK: - Matches

extension DeveloperPreview {
    static let matches: [Match] = [
        .init(id: NSUUID().uuidString, userId: users[2].id, matchTimestamp: Timestamp()),
        .init(id: NSUUID().uuidString, userId: users[3].id, matchTimestamp: Timestamp()),
    ]
}
