//
//  CardStackView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import SwiftUI

struct CardStackView: View {
    let cardModels: [CardModel]
    @ObservedObject var viewModel: CardsViewModel
    
    var body: some View {
        ZStack {
            ForEach(cardModels) { cardModel in
                CardView(viewModel: viewModel, cardModel: cardModel)
            }
        }
    }
}

#Preview {
    CardStackView(
        cardModels: DeveloperPreview.cards,
        viewModel: .init(currentUser: DeveloperPreview.user, cardService: MockCardService(),
                         matchManager: MatchManager(service: MatchService()))
    )
}
