//
//  NumberOfChildrenSelectionView.swift
//  Tinder
//
//  Created by Stephen Byron on 6/2/24.
//

import SwiftUI

struct NumberOfChildrenSelectionView: View {
    @Binding var numberOfChildren: Int

    var body: some View {
        VStack {
            Text("Enter the number of children")
                .font(.headline)
                .padding()

            TextField("Number of children", value: $numberOfChildren, format: .number)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .padding()
    }
}
