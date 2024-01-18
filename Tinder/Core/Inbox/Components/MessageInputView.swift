//
//  MessageInputView.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var messageText: String

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Type a message", text: $messageText, axis: .vertical)
                .padding(12)
                .padding(.leading, 4)
                .padding(.trailing, 48)
                .background(Color(.systemGroupedBackground))
                .clipShape(Capsule())
            
            Spacer()
            
            Button("Send") {
                print("DEBUG: Send message")
            }
            .fontWeight(.semibold)
            .padding(.horizontal)
        }
        .font(.subheadline)
    }
}

#Preview {
    MessageInputView(messageText: .constant(""))
}
