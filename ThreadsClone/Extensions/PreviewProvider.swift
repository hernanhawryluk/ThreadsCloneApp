//
//  PreviewProvider.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "Hernan Hawryluk", email: "hernan@gmail.com", username: "hernan_hawryluk")
}
