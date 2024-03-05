//
//  InboxViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase

@MainActor
class InboxViewModel: ObservableObject {
    @Published var loadingState: InboxLoadingState = .loading
    @Published var threads = [Thread]() {
        didSet { loadingState = threads.isEmpty ? .empty : .hasData }
    }
    
    private let service: InboxServiceProtocol
    private let userService: UserServiceProtocol
    
    init(service: InboxServiceProtocol, userService: UserServiceProtocol) {
        self.service = service
        self.userService = userService
        
        Task { await fetchThreads() }
    }
    
    func fetchThreads() async {
        do {
            self.threads = try await service.fetchThreads()
            await fetchThreadUserData()
            await observeThreads()
        } catch {
            print("DEBUG: Failed to fetch threads with error: \(error)")
        }
    }
    
    func observeThreads() async {
        for try await thread in service.observeThreads() {
            if let index = threads.firstIndex(where: { $0.id == thread.id }) {
                updateExistingThread(index, thread: thread)
            } else {
                await fetchUserForNewThread(thread)
            }
        }
    }
    
    func deleteThread(_ thread: Thread, currentUser: User) async throws {
        do {
            removeThreadParticipant(thread)
            try await service.deleteThread(thread, currentUser: currentUser)
            threads.removeAll(where: { $0.id == thread.id })
        } catch {
            print("DEBUG: Failed to delete thread with error: \(error)")
        }
    }
}

private extension InboxViewModel {
    func updateExistingThread(_ threadIndex: Int, thread: Thread) {
        var copy = thread

        let chatPartner = threads[threadIndex].chatPartner
        copy.chatPartner = chatPartner
        
        threads[threadIndex] = copy
        
        self.threads.remove(at: threadIndex)
        self.threads.insert(copy, at: 0)
    }
    
    func fetchThreadUserData() async {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            guard thread.chatPartner == nil else { continue }
            let user = try? await userService.fetchUser(withUid: thread.chatPartnerId)
            threads[i].chatPartner = user
        }
    }
    
    func fetchUserForNewThread(_ thread: Thread) async {
        var copy = thread

        do {
            let user = try await userService.fetchUser(withUid: thread.chatPartnerId)
            copy.chatPartner = user
            threads.append(copy)
            self.threads.sort(by: { $0.lastUpdated.dateValue() > $1.lastUpdated.dateValue() })
        } catch {
            print("DEBUG: Failed to fetch user for thread \(thread.id) with error: \(error)")
        }
    }
    
    private func removeThreadParticipant(_ thread: Thread) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let threadIndex = threads.firstIndex(where: { $0.id == thread.id }) else { return }
        threads[threadIndex].uids.removeAll(where: { $0 == currentUid })
    }
}
