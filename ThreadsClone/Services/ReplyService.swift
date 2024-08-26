//
//  ReplyServices.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

class ReplyService {
    
    @MainActor
    static func addReply(threadId: String, ownerUid: String, caption: String) async throws {
        let reply = Reply(threadId: threadId, ownerUid: ownerUid, caption: caption, timestamp: Timestamp(), likes: 0)
        
        do {
            try Firestore
                .firestore()
                .collection("replies")
                .addDocument(from: reply)
            
            try await Firestore
                .firestore()
                .collection("threads")
                .document(threadId)
                .updateData([
                    "replies": FieldValue.increment(Int64(1))
                ])
        } catch {
            print("DEBUG: Error adding reply: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    static func fetchReplies(threadId: String) async throws -> [Reply] {
        let snapshot = try await Firestore
            .firestore()
            .collection("replies")
            .whereField("threadId", isEqualTo: threadId)
            .getDocuments()
        
        let replies = snapshot.documents.compactMap({ try? $0.data(as: Reply.self) })
        
        return replies.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    @MainActor
    static func fetchRepliesByUser(ownerId: String) async throws -> [Reply] {
        let snapshot = try await Firestore
            .firestore()
            .collection("replies")
            .whereField("ownerUid", isEqualTo: ownerId)
            .getDocuments()
        
        let replies = snapshot.documents.compactMap({ try? $0.data(as: Reply.self) })
        
        return replies.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
}
