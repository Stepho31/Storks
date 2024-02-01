//
//  Name.swift
//  Tinder
//
//  Created by Brandon on 1/29/24.
//

import SwiftUI

struct FullNameView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var fullName: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your full name?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    TextField("Enter Full Name", text: $fullName)
                    
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
            NextButton()
        }
        .backgroundModifier()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

#Preview {
    NavigationStack {
        FullNameView()
            .environmentObject(OnboardingManager())
    }
}
