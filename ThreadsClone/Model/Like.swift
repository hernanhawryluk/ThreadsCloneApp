//
//  Like.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation
import FirebaseFirestore

struct Like: Identifiable, Codable {
    @DocumentID var likeId: String?
    // uid of the user who liked
    var userId: String
    // uid of the post that was liked
    var threadId: String
    
    var id: String {
        return likeId ?? NSUUID().uuidString
    }
    
    var thead: Thread?
}
