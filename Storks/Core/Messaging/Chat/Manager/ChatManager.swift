//
//  ChatManager.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/21/24.
//

import Foundation

@MainActor
class ChatManager: ObservableObject {
    @Published var messages = [ChatMessage]()
    @Published var initiateThreadObserver = false

    private let service: ChatServiceProtocol
    private let threadService: ThreadService
    
    private var thread: Thread? {
        didSet { initiateThreadObserver = thread != nil }
    }
    
    init(service: ChatServiceProtocol, thread: Thread?) {
        self.service = service
        self.thread = thread 
        self.threadService = ThreadService()
        observeMessages()
        
        initiateThreadObserver = thread != nil 
    }
    
//    func observeMessages() async {
//        guard let thread else {
//            print("DEBUG: No thread set..")
//            return
//        }
//        
//        for try await message in service.observeChatMessages(forThread: thread) {
//            self.messages.append(message)
//        }
//    }
    func observeMessages() {
         Task {
             for await message in service.observeChatMessages(forThread: thread) {
                 DispatchQueue.main.async {
                     self.messages.append(message)
                 }
             }
         }
     }
    
//    func sendMessage(_ message: String) async {
//        do {
//            try await createThreadIfNecessary()
//            try await service.sendMessage(message, toThread: thread)
//        } catch {
//            print("DEBUG: Failed to send message: \(error)")
//        }
//    }
    func sendMessage(_ text: String) async {
            do {
                try await service.sendMessage(text, toThread: thread)
            } catch {
                print("Error sending message: \(error)")
            }
        }
    
    func fetchThreadIfNecessary() async {
        guard thread == nil else { return }
        
        do {
            self.thread = try await threadService.fetchThread(withUser: service.chatPartner)
        } catch {
            print("DEBUG: Failed to fetch thread with error: \(error)")
        }
    }
}

private extension ChatManager {
    func createThreadIfNecessary() async throws {
        guard thread == nil else { return }
        
        do {
            self.thread = try await threadService.createThread(withUser: service.chatPartner)
            print("DEBUG: Thread is \(self.thread?.id)")
        } catch {
            print("DEBUG: Failed to create thread with error: \(error)")
        }
    }
}
