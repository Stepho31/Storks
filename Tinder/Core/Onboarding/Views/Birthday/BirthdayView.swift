//
//  BirthdayView.swift
//  Tinder
//
//  Created by Brandon on 1/30/24.
//

import SwiftUI

struct BirthdayView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What's your birthday?")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    
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
    BirthdayView()
        .environmentObject(OnboardingManager())
}
