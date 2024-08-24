//
//  Thread.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Firebase
import FirebaseFirestore

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
    var currentUserHasLiked: Bool?
}
