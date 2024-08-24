//
//  ThreadService.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ThreadService {
    
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func loadThread(threadId: String) async throws -> Thread {
        let snapshot = try await Firestore.firestore()
            .collection("threads")
            .document(threadId)
            .getDocument()
        
        return try snapshot.data(as: Thread.self)
    }
}
