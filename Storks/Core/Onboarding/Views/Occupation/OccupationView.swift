//
//  OccupationView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct OccupationView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your occupation?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    TextField("Enter your occupation", text: $onboardingManager.occupation)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("This is how it'll appear in your profile.")
                            .font(.footnote)
                            .opacity(0.6)
                        
                        Text("You can modify this later.")
                            .font(.footnote)
                            .bold()
                    }
                    .padding(.vertical, 6)
                }
                
                Spacer()
            }
            
            NextButton(formIsValid: formIsValid)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

extension OccupationView: FormValidatorProtocol {
    var formIsValid: Bool {
        return !onboardingManager.occupation.isEmpty
    }
}

#Preview {
    OccupationView()
        .environmentObject(OnboardingManager(service: .init()))
}
