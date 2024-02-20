//
//  BirthdayView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct BirthdayView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your birthday?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    DatePicker("Select Date", selection: $onboardingManager.birthday, displayedComponents: [.date])
                    
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
                .accentColor(.white)
                .datePickerStyle(GraphicalDatePickerStyle())
                
                Spacer()
            }
            
            NextButton(formIsValid: true)
        }
        .backgroundModifier()
        .toolbar {
            ToolbarItem(placement: .topBarLeading)
            { BackButton() }
        }
    }
}

#Preview {
    BirthdayView()
        .environmentObject(OnboardingManager(service: .init(imageUploader: .init())))
}
