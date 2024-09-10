//
//  SwipeActionButtonsView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import SwiftUI

struct SwipeActionButtonsView: View {
    let viewModel: CardsViewModel
    
    var body: some View {
        HStack(spacing: 32) {
            SwipeActionButton(viewModel: viewModel, config: .reject)

            SwipeActionButton(viewModel: viewModel, config: .like)
        }
    }
}

#Preview {
    SwipeActionButtonsView(viewModel: CardsViewModel(currentUser: DeveloperPreview.user, 
                                                     cardService: MockCardService(),
                                                     matchManager: MatchManager(service: MatchService())))
}
