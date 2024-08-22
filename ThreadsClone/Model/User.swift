//
//  User.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
