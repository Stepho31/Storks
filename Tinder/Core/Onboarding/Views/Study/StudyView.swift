//
//  StudyView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your study?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    TextField("Enter your study", text: $onboardingManager.study)
                    
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
        .backgroundModifier()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

extension StudyView: FormValidatorProtocol {
    var formIsValid: Bool {
        return !onboardingManager.study.isEmpty
    }
}

#Preview {
    StudyView()
        .environmentObject(OnboardingManager())
}
