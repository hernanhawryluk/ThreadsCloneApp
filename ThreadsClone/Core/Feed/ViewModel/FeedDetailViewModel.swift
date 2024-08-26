//
//  FeedDetailViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 26/08/2024.
//

import Foundation

class FeedDetailViewModel: ObservableObject {
    @Published var replies = [Reply]()
    
    @MainActor
    func fetchReplies(threadId: String) async throws {
        let replies = try await ReplyService.fetchReplies(threadId: threadId)
        self.replies = replies
        try await fetchUserDataForReplies()
    }
    
    @MainActor
    private func fetchUserDataForReplies() async throws {
        for i in 0 ..< replies.count {
            let reply = replies[i]
            let ownerUid = reply.ownerUid
            let user = try await UserService.fetchUser(withUid: ownerUid)
            
            replies[i].user = user
        }
    }
    
}
