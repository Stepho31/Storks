//
//  onBoardingBackgroundModifier.swift
//  Tinder
//
//  Created by Brandon on 2/1/24.
//

import Foundation
import SwiftUI

struct onBoardingBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.white)
            .background(.black)
    }
}
extension View {
    func backgroundModifier() -> some View {
        modifier(onBoardingBackgroundModifier())
    }
}
