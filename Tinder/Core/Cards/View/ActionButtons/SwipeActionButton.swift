//
//  SwipeActionButton.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/17/24.
//

import SwiftUI

struct SwipeActionButton: View {
    @ObservedObject var viewModel: CardsViewModel
    
    let config: SwipeAction
        
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(systemName: imageName)
                .fontWeight(.heavy)
                .foregroundStyle(imageForegroundStyle)
                .background {
                    Circle()
                        .fill(.white)
                        .frame(width: 48, height: 48)
                        .shadow(radius: 6)
                }
        }
        .frame(width: 48, height: 48)
    }
}

// MARK: - Computed Properties

private extension SwipeActionButton {
    private var imageName: String {
        switch config {
        case .reject:
            return "xmark"
        case .like:
            return "heart.fill"
        }
    }
    
    private var imageForegroundStyle: Color {
        switch config {
        case .reject:
            return .red
        case .like:
            return .green
        }
    }
}

// MARK: - Action Handlers

private extension SwipeActionButton {
    private func onTap() {        
        switch config {
        case .reject:
            viewModel.animatedSwipeAction = .reject
        case .like:
            viewModel.animatedSwipeAction = .like
        }
    }
}

#Preview {
    SwipeActionButton(
        viewModel: .init(currentUser: DeveloperPreview.user,
                         cardService: MockCardService(),
                         matchManager: MatchManager(service: MatchService())),
        config: .like)
}
