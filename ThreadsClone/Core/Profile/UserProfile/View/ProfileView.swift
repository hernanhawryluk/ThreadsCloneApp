//
//  ProfileView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .modifier(ButtonModifier())
                }
                
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(user: User(id: "1", fullname: "Hernan Hawryluk", email: "hernan@gmail.com", username: "hernan_hawryluk"))
}
