//
//  GenderView.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/2/24.
//

import SwiftUI

struct GenderView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var selectedGender: GenderType?
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("What's your Gender?")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(GenderType.allCases) { gender in
                    Button(action: {
                        self.selectedGender = gender
                    }, label: {
                        Text("\(gender.description)")
                            .frame(width: 300, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 25)
                            .stroke(selectedGender == gender ? .red : .white, lineWidth: 1.5))
                    })
                }
            }
            
            Spacer()
            
            NextButton()
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .background(.black)
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

#Preview {
    GenderView()
        .environmentObject(OnboardingManager())
}
