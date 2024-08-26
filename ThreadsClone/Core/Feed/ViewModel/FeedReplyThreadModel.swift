//
//  ReplyThreadViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import Foundation
import Firebase

class FeedReplyThreadModel: ObservableObject {
    
    @MainActor
    func replyThread(thread: Thread, caption: String) async throws {
        guard let uid = UserService.shared.currentUser?.id else { return }
        try await ReplyService.addReply(threadId: thread.id, ownerUid: uid, caption: caption)
    }
    
}

