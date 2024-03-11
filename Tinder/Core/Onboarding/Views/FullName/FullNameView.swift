//
//  Name.swift
//  Tinder
//
//  Created by Brandon on 1/29/24.
//

import SwiftUI

struct FullNameView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your full name?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    TextField("Enter Full Name", text: $onboardingManager.name)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("This is how it'll appear in your profile.")
                            .font(.footnote)
                            .opacity(0.6)
                        
                        Text("Can't change it later.")
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

extension FullNameView: FormValidatorProtocol {
    var formIsValid: Bool {
        return onboardingManager.name.count > 2
    }
}

#Preview {
    NavigationStack {
        FullNameView()
            .environmentObject(OnboardingManager(service: .init()))
    }
}
