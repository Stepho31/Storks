//
//  RelationshipGoalsView.swift
//  Storks
//
//  Created by Stephen Byron on 6/5/24.
//

import SwiftUI

struct RelationshipGoalsView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State var relationshipGoal: RelationshipGoalsType?

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("What are you looking for?")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 20) {
                    ForEach(RelationshipGoalsType.allCases) { goal in
                        Button(action: {
                            self.relationshipGoal = goal
                            onboardingManager.relationshipGoals = goal
                        }, label: {
                            HStack {
                                Text(goal.fullDescription)
                                
                                Spacer()
                                
                                if relationshipGoal == goal {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 14, height: 14)
                                }
                            }
                            .foregroundColor(Color.primary) 
                        })
                    }
                }
            }
            Spacer()

            NextButton(formIsValid: formIsValid)
        }
        .frame(alignment: .leading)
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton()
            }
        }
    }
}

extension RelationshipGoalsView: FormValidatorProtocol {
    var formIsValid: Bool {
        return relationshipGoal != nil
    }
}
