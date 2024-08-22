//
//  LoginViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published public var email = ""
    @Published public var password = ""
    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
