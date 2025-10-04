//
//  CardModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import Foundation

struct CardModel {
    let user: User
    var compatibilityScore: Int? = nil
}

extension CardModel: Identifiable, Hashable {
    var id: String { return user.id }
}
