//
//  InboxViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

class InboxViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    private let service: InboxServiceProtocol
    
    init(service: InboxServiceProtocol) {
        self.service = service
    }
    
    func observeThreads() {
        Task {
            for try await thread in service.observeThreads() {
                threads.append(thread)
            }
        }
    }
}
