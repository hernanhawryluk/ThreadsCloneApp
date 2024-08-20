//
//  ButtonModifier.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(Color(.systemBackground))
            .frame(width: 352, height: 44)
            .background(Color.primary)
            .cornerRadius(8)
    }
}
