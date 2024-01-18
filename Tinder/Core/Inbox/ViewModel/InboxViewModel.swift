//
//  InboxViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Foundation

class InboxViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    private let service: InboxService
    
    init(service: InboxService) {
        self.service = service
    }
}
