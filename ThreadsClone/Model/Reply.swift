//
//  Reply.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Reply: Identifiable, Codable {
    
    @DocumentID var replyId: String?
    
    let threadId: String
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    let likes: Int
    
    var id: String {
        return replyId ?? NSUUID().uuidString
    }
    
    var user: User?
}
