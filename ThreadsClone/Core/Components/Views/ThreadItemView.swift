//
//  ThreadCell.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct ThreadItemView: View {
    let thread: Thread
    
    @EnvironmentObject var currentUserProfileViewModel: CurrentUserProfileViewModel
    
    private var currentUser: User? {
        return currentUserProfileViewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            
                            if let user = thread.user{
                                NavigationLink(destination: Group {
                                    if currentUser == user {
                                        CurrentUserProfileView()
                                    } else {
                                        ProfileView(user: user)
                                    }
                                }) {
                                    Text(thread.user?.username ?? "")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                            }
                            
                            Spacer()
                            
                            
                            Text(thread.timestamp.timestampString())
                                .font(.caption)
                                .foregroundColor(Color(.systemGray))
                            
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color(.darkGray))
                            }
                        }
                        
                        NavigationLink(destination: FeedDetailView(thread: thread)) {
                            Text(thread.caption)
                                .font(.footnote)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                        
                        ThreadItemButtonsView(thread: thread)
                    }
                }
                Divider()
            }
            .padding(.top)
        }
        
    }
}

struct ThreadItemView_Preview: PreviewProvider {
    static var previews: some View {
        ThreadItemView(thread: dev.thread)
    }
}
