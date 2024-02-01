//
//  BlockUserView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/31/24.
//

import SwiftUI

struct BlockUserView: View {
    @Binding var accountRestrictionAction: UserAccountRestrictionAction?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @StateObject var blockingManager = BlockUserManager(service: BlockUserService())
    
    let user: User
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                CircularProfileImageView(user: user, size: .xLarge)
                
                Text("Block \(user.firstName)?")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("You won't see their content or see them appear in searches")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            VStack(alignment: .leading, spacing: 24) {
                AccountRestrictionInfoItemView(imageName: "exclamationmark.bubble", description: "They won't be able to message you or find your profile or content on Aurora.")
                AccountRestrictionInfoItemView(imageName: "bell.slash", description: "They won't be notified that you blocked them.")
                AccountRestrictionInfoItemView(imageName: "gear", description: "You can unblock them anytime in Settings.")
            }
            .padding()
            .padding(.horizontal, 4)
            
            Divider()
            
            Button { onBlockTapped() } label: {
                Text("Block")
                    .modifier(TinderButtonModifier())
            }
        }
        .presentationDetents([.height(520)])
        .presentationDragIndicator(.visible)
    }
    
    private func onBlockTapped() {
        Task {
            await blockingManager.blockUser(user)
            await userManager.fetchCurrentUser()
            accountRestrictionAction = .blocked
            dismiss()
        }
    }
}

#Preview {
    BlockUserView(accountRestrictionAction: .constant(nil), user: DeveloperPreview.user)
        .preferredColorScheme(.dark)
}
