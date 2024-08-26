//
//  CreateThreadViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import FirebaseAuth
import FirebaseFirestore

class CreateThreadViewModel: ObservableObject {
    
    func uploadThread(caption: String) async throws {
        guard let uid: String = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0, replies: 0)
        try await ThreadService.uploadThread(thread)
    }
}
