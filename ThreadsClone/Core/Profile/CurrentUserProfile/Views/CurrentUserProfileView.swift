//
//  CurrentUserProfileView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile: Bool = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    ProfileHeaderView(user: currentUser)
                    
                    HStack{
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit profile")
                                .modifier(SmallButtonModifier())
                        }
                        
                        ShareLink(item: URL(string: "https://hernan-hawryluk.vercel.app")!) {
                            Text("Share profile")
                                .modifier(SmallButtonModifier())
                        }
                        
                    }
                    
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser {
                    EditProfileView(user: user)
                }
            })
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
