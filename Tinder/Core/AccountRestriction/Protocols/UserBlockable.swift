//
//  UserBlockable.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/1/24.
//

import Foundation

protocol UserBlockable {
    var onBlock: (() -> Void)? { get }
}
