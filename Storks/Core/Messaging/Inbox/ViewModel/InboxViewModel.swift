//
//  InboxViewModel.swift
//  Tinder
//
//  Created by Stephan Dowless on 1/12/24.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class InboxViewModel: ObservableObject {
    @Published var loadingState: InboxLoadingState = .loading
    @Published var threads = [Thread]() {
        didSet { loadingState = threads.isEmpty ? .empty : .hasData }
    }
    
    private let service: InboxServiceProtocol
    private let userService: UserServiceProtocol
    private var firestoreListeners = [String: ListenerRegistration]()  // Track listeners to manage them
    
    init(service: InboxServiceProtocol, userService: UserServiceProtocol) {
        self.service = service
        self.userService = userService
        
//        Task { await fetchThreads() }
        Task { await fetchThreads() }
    }
    //MARK: Correct Version
//    func fetchThreads() async {
//        do {
//            self.threads = try await service.fetchThreads()
//            print("Fetched threads successfully: \(threads)")
//            await fetchThreadUserData()
//            await observeThreads()
//        } catch {
//            print("DEBUG: Failed to fetch threads with error: \(error)")
//        }
//    }
    
    func fetchThreads() async {
        do {
            var fetchedThreads = try await service.fetchThreads()
            var updatedThreads: [Thread] = []

            for var thread in fetchedThreads {
                // Fetch user details for the chat partner.
                let chatPartnerId = thread.chatPartnerId
                if !chatPartnerId.isEmpty {
                    thread.chatPartner = try? await userService.fetchUser(withUid: chatPartnerId)
                }
                // Fetch the last message for the thread.
                thread.lastMessage = try? await fetchLastMessageForThread(thread)

                updatedThreads.append(thread)
            }

            // Update UI on the main thread.
            DispatchQueue.main.async {
                self.threads = updatedThreads
                self.loadingState = self.threads.isEmpty ? .empty : .hasData
                self.observeThreadUpdates()  // Observing for real-time updates if necessary.
            }
        } catch {
            print("DEBUG: Failed to fetch threads with error: \(error)")
            DispatchQueue.main.async {
                self.loadingState = .empty
            }
        }
    }

    private func fetchLastMessageForThread(_ thread: Thread) async throws -> ChatMessage? {
        let query = Firestore.firestore().collection("messages")
                          .whereField("threadId", isEqualTo: thread.id)
                          .order(by: "timestamp", descending: true)
                          .limit(to: 1)
        
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.first?.data(as: ChatMessage.self)
    }

//
//    func fetchThreads() async {
//        do {
//            let fetchedThreads = try await service.fetchThreads()
//            DispatchQueue.main.async {
//                self.threads = fetchedThreads
//                self.loadingState = self.threads.isEmpty ? .empty : .hasData
//                self.observeThreadUpdates()
//            }
//        } catch {
//            print("DEBUG: Failed to fetch threads with error: \(error)")
//            DispatchQueue.main.async {
//                self.loadingState = .empty
//            }
//        }
//    }
    
    func observeThreads() async {
        for try await thread in service.observeThreads() {
            print("Observed new or updated thread: \(thread)")
            if let index = threads.firstIndex(where: { $0.id == thread.id }) {
                updateExistingThread(index, thread: thread)
            } else {
                await fetchUserForNewThread(thread)
            }
        }
        
//        func updateLastMessage(for threadId: String, with message: ChatMessage) {
//            if let index = threads.firstIndex(where: { $0.id == threadId }) {
//                var updatedThread = threads[index]
//                updatedThread.lastMessage = message
//                DispatchQueue.main.async {
//                    self.threads[index] = updatedThread // Reassign to trigger @Published
//                }
//            }
//        }
        
//        func observeThreadUpdates() {
//            threads.forEach { thread in
//                let query = Firestore.firestore().collection("messages")
//                    .whereField("threadId", isEqualTo: thread.id)
//                    .order(by: "timestamp", descending: true)
//                    .limit(to: 1)
//                
//                firestoreListeners[thread.id] = query.addSnapshotListener { snapshot, error in
//                    guard let snapshot = snapshot, let document = snapshot.documents.first else { return }
//                    if let lastMessage = try? document.data(as: ChatMessage.self) {
//                        DispatchQueue.main.async {
//                            if let index = self.threads.firstIndex(where: { $0.id == thread.id }) {
//                                self.threads[index].lastMessage = lastMessage
//                            }
//                        }
//                    }
//                }
//            }
//        }
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
    func observeThreadUpdates() {
        threads.forEach { thread in
            let query = Firestore.firestore().collection("messages")
                .whereField("threadId", isEqualTo: thread.id)
                .order(by: "timestamp", descending: true)
                .limit(to: 1)
            
            firestoreListeners[thread.id] = query.addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot, let document = snapshot.documents.first else { return }
                if let lastMessage = try? document.data(as: ChatMessage.self) {
                    DispatchQueue.main.async {
                        if let index = self.threads.firstIndex(where: { $0.id == thread.id }) {
                            self.threads[index].lastMessage = lastMessage
                        }
                    }
                }
            }
        }
    }
    deinit {
        firestoreListeners.forEach { $0.value.remove() }
    }
}

private extension InboxViewModel {
    func updateExistingThread(_ threadIndex: Int, thread: Thread) {
        var copy = thread
        print("Updating existing thread: \(threads[threadIndex])")

        let chatPartner = threads[threadIndex].chatPartner
        copy.chatPartner = chatPartner
        
        threads[threadIndex] = copy
        
        self.threads.remove(at: threadIndex)
        self.threads.insert(copy, at: 0)
        print("Updated thread: \(threads[threadIndex])")
    }
    
    func fetchThreadUserData() async {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            guard thread.chatPartner == nil else { continue }
            let user = try? await userService.fetchUser(withUid: thread.chatPartnerId)
            threads[i].chatPartner = user
        }
    }
//    func fetchThreadUserData() async {
//        for i in 0 ..< threads.count {
//            guard threads[i].chatPartner == nil else { continue }
//            let partnerId = threads[i].chatPartnerId
//            if !partnerId.isEmpty {
//                do {
//                    let user = try await userService.fetchUser(withUid: partnerId)
//                    DispatchQueue.main.async {
//                        self.threads[i].chatPartner = user
//                    }
//                } catch {
//                    print("Failed to fetch user data for \(partnerId): \(error)")
//                }
//            }
//        }
//    }

    
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
