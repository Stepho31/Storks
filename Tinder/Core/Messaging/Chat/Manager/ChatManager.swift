//
//  ChatManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

@MainActor
class ChatManager: ObservableObject {
    @Published var messages = [Message]()
    
    private let service: ChatServiceProtocol
    
    init(service: ChatServiceProtocol) {
        self.service = service
        
        Task { await observeMessages() }
    }
    
    func observeMessages() async {
        for try await message in service.observeChatMessages() {
            self.messages.append(message)
        }
    }
    
    func sendMessage(_ message: String) async {
        do {
            try await service.sendMessage(message)
        } catch {
            print("DEBUG: Failed to send message: \(error)")
        }
    }
}
