//
//  ChatBubbleModifier.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct ChatBubbleModifier: ViewModifier {
    let isFromCurrentUser: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(messageBackgroundColor)
            .foregroundStyle(messageTextColor)
            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser, shouldRoundAllCorners: false))
            .frame(maxWidth: maxWidth, alignment: alignment)
            .padding(.horizontal)
    }
}

private extension ChatBubbleModifier {
    var messageBackgroundColor: Color {
        return isFromCurrentUser ? .blue : Color(.secondarySystemBackground)
    }
    
    var messageTextColor: Color {
        return .primary
    }
    
    var maxWidth: CGFloat {
        return UIScreen.main.bounds.width / 1.5
    }
    
    var alignment: Alignment {
        return isFromCurrentUser ? .trailing : .leading
    }
}
