//
//  UserService.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import FirebaseAuth
import FirebaseFirestore

class UserService {
    // published property to store the current user data
    @Published public var currentUser: User?
    
    // shared instance for the UserService class
    static let shared = UserService()
    
    // initializes the UserService fetching the current user data
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        // retrieves the current user's UID from FirebaseAuth
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // fetches the user document from Firestore using the UID as reference
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        // Decodes the document data into a "User" object
        let user = try snapshot.data(as: User.self)
        // updates currentUser with the user's data
        self.currentUser = user
    }
    
    static func fetchUsers(limit: Int, startAfter: DocumentSnapshot? = nil) async throws -> [User] {
        // retrives the current user's UID from FirebaseAuth
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        // sets up a query to the "users" collection with a limit on the number of documents to fetch
        let query = Firestore.firestore().collection("users").limit(to: limit)
        
        let snapshot: QuerySnapshot
        // If there is a document to start after (for pagination)
        if let startAfter = startAfter {
            // fetches the documents starting after that document
            snapshot = try await query.start(afterDocument: startAfter).getDocuments()
        } else {
            // fetches from the beginning
            snapshot = try await query.getDocuments()
        }
        // Maps the fetched documents to an array of "User" objects
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        // Filters out the current user and returns the other users' data
        return users.filter({ $0.id != currentUid })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User{
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func reset() {
        // resets the current user data to nil
        self.currentUser = nil
    }
    
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
