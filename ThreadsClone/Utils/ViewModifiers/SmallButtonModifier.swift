//
//  SmallButtonModifier.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import SwiftUI

struct SmallButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(Color.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 32)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            }
    }
}
