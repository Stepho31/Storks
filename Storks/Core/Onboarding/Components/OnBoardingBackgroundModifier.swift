//
//  OnBoardingBackgroundModifier.swift
//  Tinder
//
//  Created by Brandon on 2/1/24.
//

import Foundation
import SwiftUI

struct OnBoardingBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
    }
}
extension View {
    func backgroundModifier() -> some View {
        modifier(OnBoardingBackgroundModifier())
    }
}
