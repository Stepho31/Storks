//
//  CardView.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import SwiftUI

struct CardView: View {
    @State private var xOffset: CGFloat = 0
    @State private var degrees: Double = 0
    @State private var currentImageIndex = 0
    @State private var showProfileView = false
    
    @ObservedObject var viewModel: CardsViewModel
    
    let cardModel: CardModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .top) {
                CardImageView(user: user, currentImageIndex: $currentImageIndex)
                
                CardImageIndicatorView(imageCount: user.numberOfImages, currentIndex: $currentImageIndex)
                
                SwipeActionIndicatorView(xOffset: xOffset)
            }
            
            UserInfoView(user: user, showProfileView: $showProfileView)
        }
        .fullScreenCover(isPresented: $showProfileView) {
            UserProfileView(onBlock: onBlock, user: user)
        }
        .onReceive(viewModel.$animatedSwipeAction, perform: { action in
            onReceiveSwipeAction(action)
        })
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
    }
}

// MARK: - Computed Properties

private extension CardView {
    var user: User {
        return cardModel.user
    }
}

// MARK: - Swiping Helper Methods

private extension CardView {
    func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    func swipeRight() {
        withAnimation {
            xOffset = 500
            degrees = 12
        } completion: {
            Task { await viewModel.likeUser(user) }
        }
    }
    
    func swipeLeft() {
        withAnimation {
            xOffset = -500
            degrees = -12
        } completion: {
            Task { try await viewModel.rejectUser(user) }
        }
    }
    
    func onReceiveSwipeAction(_ action: SwipeAction?) {
        guard let action, 
        let topCard = viewModel.cardModels.last,
        topCard == cardModel else { return }
        
        switch action {
        case .reject:
            swipeLeft()
        case .like:
            swipeRight()
        }
    }
    
    func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        xOffset = value.translation.width
        degrees = Double(value.translation.width / 25)
    }
    
    func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        
        if abs(width) <= abs(SizeConstants.screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= SizeConstants.screenCutoff && width > 0 {
            swipeRight()
        } else {
            swipeLeft()
        }
    }
}

// MARK: - Account Restriction Handlers

private extension CardView {
    func onBlock() {
        viewModel.animatedSwipeAction = .reject
    }
}

#Preview {
    CardView(
        viewModel: .init(currentUser: DeveloperPreview.user,
                         cardService: MockCardService(),
                         matchManager: MatchManager(service: MatchService())),
        cardModel: CardModel(user: DeveloperPreview.user)
    )
}
