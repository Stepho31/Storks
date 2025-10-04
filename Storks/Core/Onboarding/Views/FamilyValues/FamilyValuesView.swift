//
//  FamilyValuesView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI

struct FamilyValuesView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State private var selected: Set<FamilyValueType> = []
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Which family values matter most to you?")
                    .font(.title)
                    .bold()
                
                ForEach(FamilyValueType.allCases) { value in
                    Button {
                        toggle(value)
                    } label: {
                        HStack {
                            Text(value.description)
                            Spacer()
                            if selected.contains(value) { Image(systemName: "checkmark") }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            Spacer()
            NextButton(formIsValid: !selected.isEmpty)
        }
        .onAppear { selected = Set(onboardingManager.selectedFamilyValues) }
        .onChange(of: selected) { _, newValue in
            onboardingManager.selectedFamilyValues = Array(newValue)
        }
        .padding()
        .toolbar { ToolbarItem(placement: .topBarLeading) { BackButton() } }
    }
    
    private func toggle(_ value: FamilyValueType) {
        if selected.contains(value) { selected.remove(value) } else { selected.insert(value) }
    }
}
