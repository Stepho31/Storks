//
//  ChatBubbleModifier.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct ChatBubbleModifier: ViewModifier {
    let isFromCurrentUser: Bool
    
    var messageBackgroundColor: Color {
        return isFromCurrentUser ? Color(.systemGray6) : .blue
    }
    
    var messageTextColor: Color {
        return isFromCurrentUser ? .black : .white
    }
    
    var maxWidth: CGFloat {
        return UIScreen.main.bounds.width / 1.5
    }
    
    var alignment: Alignment {
        return isFromCurrentUser ? .trailing : .leading
    }
    
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

