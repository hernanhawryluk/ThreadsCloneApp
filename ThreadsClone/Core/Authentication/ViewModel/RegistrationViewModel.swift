//
//  RegistrationViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 21/08/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var fullname: String = ""
    @Published public var username: String = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullname,
            username: username
        )
    }
}
