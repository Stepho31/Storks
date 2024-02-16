//
//  MockInboxService.swift
//  Tinder
//
//  Created by Stephan Dowless on 2/16/24.
//

import Foundation

struct MockInboxService: InboxServiceProtocol {
    func fetchThreads() async throws -> [Thread] {
        return []
    }
    
    func observeThreads() -> AsyncStream<Thread> {
        return AsyncStream { continuation in
            
        }
    }
    
    func deleteThread(_ thread: Thread, currentUser: User) async throws {
        
    }    
}
