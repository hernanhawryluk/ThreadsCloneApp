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
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel: CurrentUserProfileViewModel
    
    private var currentUser: User? {
        return userViewModel.currentUser
    }
    

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: thread.user, size: .xSmall)
                            
                            Rectangle()
                                .frame(maxWidth: 1, maxHeight: .infinity)
                                .foregroundColor(.gray)
                                .padding(.vertical, 2)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(thread.user?.username ?? "")
                                .fontWeight(.semibold)
                            
                            Text(thread.caption)
                            
                        }
                        .font(.footnote)
                        .foregroundColor(.primary)
                    }
                    .padding()
                    
                    
                    Divider()
                    
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
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        
                        CircularProfileImageView(user: currentUser, size: .xxSmall)
                        
                        Text("Add another reply")
                            .fontWeight(.medium)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                    }
                    .padding(.horizontal, 24)
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
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
    }
}

struct FeedDetailView_Preview: PreviewProvider {
    static var previews: some View {
        FeedDetailView(thread: dev.thread)
    }
}
