//
//  AuthService.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 21/08/2024.
//

import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    // allows other parts of the app to track the current user session
    @Published public var userSession: FirebaseAuth.User?
    
    // creates a shared instance of the class
    static let shared = AuthService()
    
    // initializes the session with the current authenticated user from Firebase
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            // authenticates the user in Firebase
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // updates the session with the logged in user
            self.userSession = result.user
            // fetches the current user's data
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed login user with error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            // creates a new user in Firebase
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // updates the session with the new created user
            self.userSession = result.user
            // uploads the user's data to Firestore
            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        // signs out on firebase backend
        try? Auth.auth().signOut()
        // removes session locally and updates routing
        self.userSession = nil
        // sets the current user object to nil
        UserService.shared.reset()
    }
    
    private func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws {
        // creates a user object with the provided details
        let user = User(id: id, fullname: fullname, email: email, username: username)
        // Encodes the User object into Firestore data format
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        // Uploads the user's data to Firestore under the "users" collection
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        // Sets the current user data to use it in other parts of the app
        UserService.shared.currentUser = user
    }
}
