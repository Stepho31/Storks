//
//  ChatView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct ChatView: View {
    let user: User
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(DeveloperPreview.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
            }
                        
            MessageInputView(messageText: $messageText)
                .padding()
        }
        .navigationTitle(user.firstName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView(user: DeveloperPreview.users[1])
    }
}
