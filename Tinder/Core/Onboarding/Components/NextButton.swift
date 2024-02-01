//
//  NextButton.swift
//  Tinder
//
//  Created by Brandon on 2/1/24.
//

import SwiftUI

struct NextButton: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    var body: some View {
        Button {
            onboardingManager.navigate()
        } label: {
            Text("Next")
                .foregroundStyle(.white)
                .bold()
                .font(.title3)
                .frame(width: 320, height: 50)
                .background(Color(.primaryPink))
                .clipShape(Capsule())
        }
    }
}

//#Preview {
//    NextButton()
//}
