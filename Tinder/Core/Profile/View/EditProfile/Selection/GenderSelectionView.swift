//
//  GenderSelectionView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct GenderSelectionView: View {
    @Binding var selectedGender: GenderType?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Select Gender") {
                        ForEach(GenderType.allCases) { gender in
                            HStack {
                                Text(gender.description)
                                
                                Spacer()
                                
                                if selectedGender == gender {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .background(Color(.secondarySystemBackground))
                            .onTapGesture { selectedGender = gender }
                        }
                    }
                }
            }
            .navigationTitle("I Am")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    GenderSelectionView(selectedGender: .constant(.man))
}
