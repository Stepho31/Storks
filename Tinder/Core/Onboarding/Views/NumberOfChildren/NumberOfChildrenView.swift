//
//  NumberOfChildrenView.swift
//  Tinder
//
//  Created by Stephen Byron on 6/1/24.
//

import SwiftUI

struct NumberOfChildrenView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("How many children do you have?")
                    .font(.title)
                    .bold()
                
                TextField("Enter number of children", value: $onboardingManager.numberOfChildren, format: .number)
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("You can update this information later in your profile settings.")
                        .font(.footnote)
                        .opacity(0.6)
                }
                .padding(.vertical, 6)
                
                Spacer()
            }
            
            NextButton(formIsValid: onboardingManager.formIsValid)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading)
            { BackButton() }
        }
    }
}

extension NumberOfChildrenView: FormValidatorProtocol {
    var formIsValid: Bool {
        return onboardingManager.numberOfChildren >= 0 // Adjust validation as needed
    }
}
