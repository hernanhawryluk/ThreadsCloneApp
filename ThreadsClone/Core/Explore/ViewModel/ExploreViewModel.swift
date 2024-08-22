//
//  ExploreViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchUsers()
        }
    }
     
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers(limit: 20)
    }
}
