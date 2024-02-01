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
                
                ImageIndicatorView(imageCount: user.numberOfImages, currentIndex: $currentImageIndex)
                
                SwipeActionIndicatorView(xOffset: $xOffset, screenCutoff: screenCutoff)
            }
            
            UserInfoView(user: user, showProfileView: $showProfileView)
        }
        .fullScreenCover(isPresented: $showProfileView, content: {
            UserProfileView(onBlock: onBlock, user: user)
        })
        .onReceive(viewModel.$animatedSwipeAction, perform: { action in
            onReceiveSwipeAction(action)
        })
        .frame(width: SizeConstants.cardWidth, height: SizeConstants.cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(x: xOffset, y: 0)
        .rotationEffect(.degrees(degrees))
        .animation(.snappy, value: xOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.snappy) {
                        guard !viewModel.animating else { return }
                        
                        xOffset = value.translation.width
                        degrees = Double(value.translation.width / 25)
                    }
                }
                .onEnded { value in
                    onDragEnded(value)
                }
        )
    }
}

// MARK: - Computed Properties

private extension CardView {
    private var screenCutoff: CGFloat {
        return (UIScreen.main.bounds.width / 2) * 0.8
    }
    
    private var imageIndicatorWidth: CGFloat {
        return SizeConstants.cardWidth / CGFloat(user.profileImageURLs.count) - 28
    }
    
    private var user: User {
        return cardModel.user
    }
}

// MARK: - Swiping Helper Methods

private extension CardView {
    private func returnToCenter() {
        xOffset = 0
        degrees = 0
    }
    
    private func swipeRight() {
        guard !viewModel.animating else { return }

        xOffset = 500
        degrees = 12
        
        Task { try await viewModel.likeUser(user) }
    }
    
    private func swipeLeft() {
        guard !viewModel.animating else { return }

        xOffset = -500
        degrees = -12
        
        Task { try await viewModel.rejectUser(user) }
    }
    
    private func onReceiveSwipeAction(_ action: SwipeAction?) {
        guard let action else { return }
        let topCard = viewModel.cardModels.last
        
        if topCard == cardModel {
            switch action {
            case .reject:
                swipeLeft()
            case .like:
                swipeRight()
            }
        }
    }
    
    private func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        let width = value.translation.width
        
        if abs(width) <= abs(screenCutoff) {
            returnToCenter()
            return
        }
        
        if width >= screenCutoff  && width > 0 {
            swipeRight()
        } else {
            swipeLeft()
        }
    }
}

// MARK: - Account Restriction Handlers

extension CardView {
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
