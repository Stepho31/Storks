//
//  InboxViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

enum InboxLoadingState {
    case loading
    case empty
    case hasData
}

class InboxViewModel: ObservableObject {
    @Published var threads = [Thread]()
    @Published var loadingState: InboxLoadingState = .loading
    
    private let service: InboxServiceProtocol
    
    init(service: InboxServiceProtocol) {
        self.service = service
    }
    
    func observeThreads() {
        Task {
            for try await thread in service.observeThreads() {
                threads.append(thread)
            }
            
            loadingState = threads.isEmpty ? .empty : .hasData
        }
    }
}
