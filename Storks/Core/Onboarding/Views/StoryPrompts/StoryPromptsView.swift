//
//  StoryPromptsView.swift
//  Storks
//
//  Created by Cursor AI on 10/4/25.
//

import SwiftUI

struct StoryPromptsView: View {
    @EnvironmentObject var onboardingManager: OnboardingManager
    
    @State private var answers: [String: String] = [:]
    private let prompts: [String] = [
        "The funniest thing my kid ever did was…",
        "A weekend with my family looks like…",
        "My go-to kid-friendly meal is…"
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tell your story")
                        .font(.title)
                        .bold()
                    
                    ForEach(prompts, id: \.self) { prompt in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(prompt).font(.subheadline).bold()
                            TextField("Your answer", text: Binding(
                                get: { answers[prompt, default: ""] },
                                set: { answers[prompt] = $0 }
                            ), axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                        }
                    }
                }
                .padding(.bottom, 8)
            }
            
            NextButton(formIsValid: true)
        }
        .onDisappear(perform: persistAnswers)
        .padding()
        .toolbar { ToolbarItem(placement: .topBarLeading) { BackButton() } }
    }
    
    private func persistAnswers() {
        let entries: [StoryPromptAnswer] = prompts.compactMap { prompt in
            guard let text = answers[prompt], !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
            return StoryPromptAnswer(id: UUID().uuidString, prompt: prompt, answer: text)
        }
        onboardingManager.storyAnswers = entries
    }
}
