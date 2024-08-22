//
//  CurrentUserProfileView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    ProfileHeaderView(user: currentUser)
                    
                    Button {
                        
                    } label: {
                        Text("Edit Profile")
                            .modifier(SmallButtonModifier())
                    }
                    
                    UserContentView()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
