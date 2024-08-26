//
//  UserContentViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    var user: User
    
    init(user: User) {
        self.user = user
        Task {
            try await fetchUserThreads()
        }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        self.threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        
        self.threads = threads
    }
}
