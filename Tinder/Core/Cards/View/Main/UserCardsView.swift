//
//  CardStackView.swift
//  Tinder
//
//  Created by Stephan Dowless on 12/31/23.
//

import SwiftUI

struct UserCardsView: View {
    @ObservedObject var userManager: UserManager
    @ObservedObject var matchManager: MatchManager
    
    @State private var showMatchView = false
    @StateObject var viewModel: CardsViewModel

    init(userManager: UserManager, matchManager: MatchManager) {
        self.userManager = userManager
        self.matchManager = matchManager
        
        let viewModel = CardsViewModel(
            currentUser: userManager.currentUser,
            cardService: MockCardService(),
            matchManager: matchManager
        )
        
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                            .environmentObject(viewModel)
                    case .hasData(let cardModels):
                        VStack {
                            CardStackView(cardModels: cardModels, viewModel: viewModel)
                            
                            SwipeActionButtonsView(viewModel: viewModel)
                        }
                    }

                    Spacer()
                }
                .padding(.top)
                .blur(radius: showMatchView ? 20 : 0)
                
                if showMatchView {
                    UserMatchView(show: $showMatchView)
                        .onDisappear { matchManager.matchedUser = nil }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ChatView(user: user, thread: nil)
            })
            .onReceive(matchManager.$matchedUser, perform: { user in
               showMatchView = user != nil 
            })
            .toolbar(showMatchView ? .hidden : .visible, for: .navigationBar)
            .toolbar(showMatchView ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarLogo()
                }
            }
            .animation(.easeInOut, value: showMatchView)
        }
    }
}

#Preview {
    UserCardsView(
        userManager: UserManager(service: MockUserService()),
        matchManager: MatchManager(service: MatchService())
    )
}
