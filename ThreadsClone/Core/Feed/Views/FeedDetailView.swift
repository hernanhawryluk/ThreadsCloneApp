//
//  FeedDetailView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 26/08/2024.
//

import SwiftUI

struct FeedDetailView: View {
    var thread: Thread
    
    @StateObject var viewModel = FeedDetailViewModel()
    @State private var showReplySheet: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel: CurrentUserProfileViewModel
    
    private var currentUser: User? {
        return userViewModel.currentUser
    }
    

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            CircularProfileImageView(user: thread.user, size: .small)
                            Text(thread.user?.username ?? "")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(thread.timestamp.timestampString())
                                .font(.caption)
                                .foregroundColor(Color(.systemGray))
                        }
                        Text(thread.caption)
                            .font(.footnote)
                            .foregroundColor(.primary)
                        ThreadItemButtonsView(thread: thread)
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Divider()
                        
                        HStack {
                            Text("Replies")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                HStack {
                                    Text("View activity")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Image(systemName: "chevron.forward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 4)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        Divider()
                    }
                    
                    
                    ForEach(viewModel.replies) { reply in
                        HStack(alignment: .top) {
                            VStack {
                                CircularProfileImageView(user: reply.user, size: .xSmall)
                                
                                Rectangle()
                                    .frame(maxWidth: 1, maxHeight: .infinity)
                                    .foregroundColor(.gray)
                                    .padding(.vertical, 2)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(reply.user?.username ?? "")
                                    .fontWeight(.semibold)
                                
                                Text(reply.caption)
                                
                            }
                            .font(.footnote)
                            .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchReplies(threadId: thread.id)
                    } catch {
                        print("DEBUG: Error fetching replies: \(error.localizedDescription)")
                    }
                }
            }
            .refreshable {
                Task { try await viewModel.fetchReplies(threadId: thread.id) }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 8)
                            Text("Back")
                                .foregroundStyle(.primary)
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Thread")
                            .font(.headline)
                        Text("5k views")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17)
                            .foregroundColor(.primary)
                            
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 8)
            .sheet(isPresented: $showReplySheet, content: {
                FeedReplyView(thread: thread)
            })
        }
        
        HStack {
            CircularProfileImageView(user: userViewModel.currentUser, size: .xxSmall)
            
            Button {
                showReplySheet.toggle()
            } label: {
                Text("Reply to \(thread.user?.username ?? "")...")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 16)

    }
}

struct FeedDetailView_Preview: PreviewProvider {
    static var previews: some View {
        let userViewModel = CurrentUserProfileViewModel()
        userViewModel.currentUser = User(id: "1", fullname: "John Doe", email: "john@example.com", username: "john_doe")
        return FeedDetailView(thread: dev.thread)
            .environmentObject(userViewModel)
    }
}
