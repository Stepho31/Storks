//
//  CardStackState.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/18/24.
//

import Foundation

enum CardStackState {
    case loading
    case empty
    case hasData([CardModel])
}
