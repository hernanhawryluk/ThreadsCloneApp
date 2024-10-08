//
//  FeedViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
    @Published public var threads = [Thread]()
    @Published public var lastDocument: DocumentSnapshot?
    @Published public var loading = false
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    @MainActor
    func fetchThreads() async throws {
        self.loading = true
        self.threads = []
        self.lastDocument = nil
        let (threads, lastDocument) = try await ThreadService.fetchThreads(limit: 20)
        self.threads = threads
        self.lastDocument = lastDocument
        try await fetchUserDataForThreads()
        self.loading = false
    }
    
    @MainActor
    func fetchMoreThreads() async throws {
        self.loading = true
        let (threads, lastDocument) = try await ThreadService.fetchThreads(limit: 20, afterDocument: self.lastDocument)
        if threads.count > 0 {
            self.threads.append(contentsOf: threads)
            self.lastDocument = lastDocument
            try await fetchUserDataForThreads()
        }
        self.loading = false
    }
    
    @MainActor
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            if threads[i].user == nil {
                let thread = threads[i]
                let ownerUid = thread.ownerUid
                let threadUser = try await UserService.fetchUser(withUid: ownerUid)
                
                threads[i].user = threadUser
            }
        }
    }
    
    @MainActor
    func likeThread(thread: Thread) async throws {
        guard let uid = UserService.shared.currentUser?.id else { return }
        try await LikeService.likeThead(userId: uid, threadId: thread.id)
        try await reloadThread(thread: thread)
    }
    
    @MainActor
    private func reloadThread(thread: Thread) async throws {
        guard let uid = UserService.shared.currentUser?.id else { return }
        do {
            
            // Find the index of the thread in the threads array
            if let index = threads.firstIndex(where: { $0.id == thread.id }) {
                var updatedThread = try await ThreadService.loadThread(threadId: thread.id)
                let hasLiked = try await LikeService.userHasLikedThread(userId: uid, threadId: thread.id)
                // Replace the thread at the found index with the updated thread
                updatedThread.user = thread.user
                updatedThread.currentUserHasLiked = hasLiked
                threads[index] = updatedThread
            }
        } catch {
            print("Error reload : \(error)")
        }
    }
}
