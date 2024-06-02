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
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 352, height: 44)
                .foregroundStyle(formIsValid ? .white : .black.opacity(0.5))
                .background(formIsValid ? Color(.primaryBlue) : Color(.systemGray5))
                .clipShape(Capsule())
        }
        .disabled(!formIsValid)
    }
}

//#Preview {
//    NextButton()
//}
