//
//  LikeService.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class LikeService {
    static func likeThead(userId: String, threadId: String) async throws {
        do {
            // checks if the user already liked the thread
            let querySnapshot = try await Firestore
                .firestore()
                .collection("likes")
                .whereField("userId", isEqualTo: userId)
                .whereField("threadId", isEqualTo: threadId)
                .getDocuments()
            
            // user has not liked the thread
            if querySnapshot.documents.isEmpty {
                // add a new like document
                let like = Like(userId: userId, threadId: threadId)
                try Firestore
                    .firestore()
                    .collection("likes")
                    .addDocument(from: like)
                
                // increments the like count on the thread
                try await Firestore
                    .firestore()
                    .collection("threads")
                    .document(threadId)
                    .updateData([
                        "likes": FieldValue.increment(Int64(1))
                    ])
            // if user has already liked the thread
            } else {
                for document in querySnapshot.documents {
                    // deletes the like document
                    let likeId = document.documentID
                    try await Firestore
                        .firestore()
                        .collection("likes")
                        .document(likeId)
                        .delete()
                    
                    // decrement the like count on the thread
                    try await Firestore
                        .firestore()
                        .collection("threads")
                        .document(threadId)
                        .updateData([
                            "likes": FieldValue.increment(Int64(-1))
                        ])
                }
            }
        } catch {
            print("DEBUG: Error liking or unliking a thread: \(error.localizedDescription)")
        }
    }
    
    static func userHasLikedThread(userId: String, threadId: String) async throws -> Bool {
        let snapshot = try await Firestore
            .firestore()
            .collection("likes")
            .whereField("userId", isEqualTo: userId)
            .whereField("threadId", isEqualTo: threadId)
            .getDocuments()
        
        return snapshot.documents.isEmpty ? false : true
    }
    
    static func fetchUserLikes(userId: String) async throws -> [Like] {
        let snapshot = try await Firestore
            .firestore()
            .collection("likes")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Like.self) })
    }
}
