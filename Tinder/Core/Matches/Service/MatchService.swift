//
//  MatchService.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

protocol MatchServiceProtocol {
    func fetchPotentialMatchIDs() async throws -> [String]
    func fetchMatches() async throws -> [Match]
}
