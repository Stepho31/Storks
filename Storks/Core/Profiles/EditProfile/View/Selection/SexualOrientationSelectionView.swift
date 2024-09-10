//
//  SexualOrientationSelectionView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct SexualOrientationSelectionView: View {
    @Binding var selectedOrientation: SexualOrientationType?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Select Orientation") {
                        ForEach(SexualOrientationType.allCases) { orientation in
                            HStack {
                                Text(orientation.description)
                                
                                Spacer()
                                
                                if selectedOrientation == orientation {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .background(Color(.secondarySystemBackground))
                            .onTapGesture { selectedOrientation = orientation }
                        }
                    }
                }
            }
            .navigationTitle("Orientation")
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
    SexualOrientationSelectionView(selectedOrientation: .constant(.straight))
}
