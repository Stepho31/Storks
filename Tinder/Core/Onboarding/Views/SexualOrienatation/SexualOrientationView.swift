//
//  SexualOrientationView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/2/24.
//

import SwiftUI

struct SexualOrientationView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var sexualOrientation: SexualOrientationType?

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your sexual orientation?")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 20) {
                    ForEach(SexualOrientationType.allCases) { orientation in
                        Button(action: {
                            self.sexualOrientation = orientation
                        }, label: {
                            HStack {
                                Text(orientation.description)
                                
                                Spacer()
                                
                                if sexualOrientation == orientation {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 14 ,height: 14)
                                        .foregroundStyle(.white)
                                }
                            }
                        })
                    }
                }
            }
            Spacer()

            NextButton()
        }
        .frame(alignment: .leading)
        .padding()
        .foregroundStyle(.white)
        .background(.black)
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

#Preview {
    SexualOrientationView()
        .environmentObject(OnboardingManager())
}
