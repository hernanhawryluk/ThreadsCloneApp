//
//  File.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        self.user = UserService.shared.currentUser
    }
}
