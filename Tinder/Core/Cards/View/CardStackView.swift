//
//  CardStackView.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import SwiftUI

struct CardStackView: View {
    @ObservedObject var userManager: UserManager
    @StateObject var viewModel: CardsViewModel
    @State private var currentCardXOffset: CGFloat = 0.0
    @State private var showMatchView = false
    
    init(userManager: UserManager) {
        self.userManager = userManager
        self._viewModel = StateObject(wrappedValue: CardsViewModel(userManager: userManager))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    switch viewModel.cardStackState {
                    case .loading:
                        CardsLoadingView()
                    case .empty:
                        CardStackEmptyStateView()
                    case .hasData:
                        VStack {
                            ZStack {
                                ForEach(viewModel.cardModels) { cardModel in
                                    CardView(viewModel: viewModel, cardModel: cardModel)
                                }
                            }
                            
                            HStack(spacing: 32) {
                                SwipeActionButton(viewModel: viewModel, config: .reject)

                                SwipeActionButton(viewModel: viewModel, config: .like)
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.top)
                .blur(radius: showMatchView ? 20 : 0)
                
                if showMatchView {
                    UserMatchView(show: $showMatchView, cardsViewModel: viewModel)
                }
            }
            .onReceive(viewModel.$matchedUser, perform: { user in
               showMatchView = user != nil 
            })
            .toolbar(showMatchView ? .hidden : .visible, for: .navigationBar)
            .toolbar(showMatchView ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.tinderLogo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 88)
                }
            }
            .animation(.easeInOut, value: showMatchView)
        }
    }
}

#Preview {
    CardStackView(userManager: UserManager(service: MockUserService()))
}
