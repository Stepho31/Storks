//
//  CardService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

protocol CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel]
}

struct CardService: CardServiceProtocol {
    func fetchCards(for currentUser: User) async throws -> [CardModel] {
        return [] 
    }
}
