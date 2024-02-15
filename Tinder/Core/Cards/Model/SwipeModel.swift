//
//  SwipeModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/15/24.
//

import Foundation

struct SwipeModel: Codable {
    let didLike: SwipeAction
    let uid: String
}
