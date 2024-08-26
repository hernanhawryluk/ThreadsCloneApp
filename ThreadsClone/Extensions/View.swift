//
//  View.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 26/08/2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

