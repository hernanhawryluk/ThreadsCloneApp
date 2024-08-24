//
//  FeedViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published public var threads = [Thread]()
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    @MainActor
    func fetchThreads() async throws {
        try await self.threads = ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }
    
    @MainActor
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            threads[i].user = threadUser
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
