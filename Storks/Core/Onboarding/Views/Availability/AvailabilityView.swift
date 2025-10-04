//
//  AvailabilityView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI

struct AvailabilityView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    @State private var selected: Set<AvailabilityPreset> = []
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("When are you usually free?")
                    .font(.title)
                    .bold()
                
                ForEach(AvailabilityPreset.allCases) { preset in
                    Button {
                        toggle(preset)
                    } label: {
                        HStack {
                            Text(preset.description)
                            Spacer()
                            if selected.contains(preset) { Image(systemName: "checkmark") }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            Spacer()
            NextButton(formIsValid: !selected.isEmpty)
        }
        .onAppear { selected = Set(onboardingManager.availability) }
        .onChange(of: selected) { _, newValue in
            onboardingManager.availability = Array(newValue)
        }
        .padding()
        .toolbar { ToolbarItem(placement: .topBarLeading) { BackButton() } }
    }
    
    private func toggle(_ value: AvailabilityPreset) {
        if selected.contains(value) { selected.remove(value) } else { selected.insert(value) }
    }
}
