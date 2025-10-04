//
//  ParentingStyleView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI

struct ParentingStyleView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State private var selected: ParentingStyleType?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("How would you describe your parenting style?")
                    .font(.title)
                    .bold()
                
                ForEach(ParentingStyleType.allCases) { style in
                    Button {
                        selected = style
                        onboardingManager.parentingStyle = style
                    } label: {
                        HStack {
                            Text(style.description)
                            Spacer()
                            if selected == style { Image(systemName: "checkmark") }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            Spacer()
            NextButton(formIsValid: selected != nil)
        }
        .padding()
        .toolbar { ToolbarItem(placement: .topBarLeading) { BackButton() } }
    }
}
