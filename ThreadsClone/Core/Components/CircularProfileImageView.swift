//
//  CircularProfileImageView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("temp-profile-img")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CircularProfileImageView()
}
