//
//  NextButton.swift
//  Tinder
//
//  Created by Brandon on 2/1/24.
//

import SwiftUI

struct NextButton: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    let formIsValid: Bool
    
    var body: some View {
        Button {
            onboardingManager.navigate()
        } label: {
            Text("Next")
                .foregroundStyle(formIsValid ? .white : .black.opacity(0.5))
                .bold()
                .font(.title3)
                .frame(width: 300, height: 50)
                .background(formIsValid ? Color(.primaryPink) : Color(.systemGray5))
                .clipShape(Capsule())
        }
        .disabled(!formIsValid)
    }
}

//#Preview {
//    NextButton()
//}
