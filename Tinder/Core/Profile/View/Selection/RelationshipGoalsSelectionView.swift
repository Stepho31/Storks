//
//  RelationshipGoalsSelectionView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/2/24.
//

import SwiftUI

struct RelationshipGoalsSelectionView: View {
    let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    @Binding var selectedGoalType: RelationshipGoalsType?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 8) {
                Text("Right now I'm looking for...")
                    .font(.headline)
                
                Text("Increase compatibility by sharing yours!")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(RelationshipGoalsType.allCases) { type in
                    VStack {
                        Text(type.emoji)
                            .font(.title)
                        
                        Text(type.description)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 4)
                    }
                    .frame(width: 108, height: 108)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        withAnimation(.spring) {
                            selectedGoalType = type
                            dismiss()
                        }
                    }
                    .overlay {
                        if type == selectedGoalType {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 2.0)
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
        .background(.white.opacity(0.01))
        
    }
}

#Preview {
    RelationshipGoalsSelectionView(selectedGoalType: .constant(.longTermOpenToShort))
}
