//
//  FeedReplyView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import SwiftUI

struct FeedReplyView: View {
    var thread: Thread
    
    @State private var replyCaption: String = ""
    @State private var loading: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var viewModel = FeedReplyThreadModel()
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userViewModel: CurrentUserProfileViewModel
    @EnvironmentObject var toastViewModel: ToastViewModel
    
    private var currentUser: User? {
        return userViewModel.currentUser
    }
    

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    
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
                    
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: currentUser, size: .xSmall)
                            
                            Rectangle()
                                .frame(maxWidth: 1, maxHeight: .infinity)
                                .foregroundColor(.gray)
                                .padding(.vertical, 2)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(currentUser?.username ?? "")
                                .fontWeight(.semibold)
                            
                            TextField("Reply to \(thread.user?.username ?? "")...", text: $replyCaption, axis: .vertical)
                                .multilineTextAlignment(.leading)
                                .focused($isTextFieldFocused)
                            
                            ThreadAttachments()
                            
                        }
                        .font(.footnote)
                        .foregroundColor(.primary)
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
                isTextFieldFocused = true
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
            
            HStack {
                Text("Anyone can reply & quote")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
                Spacer()
                
                Button {
                    dismiss()
                    toastViewModel.showToast(message: "Posting...", status: .loading)
                    Task {
                        try await viewModel.replyThread(thread: thread, caption: replyCaption)
                        replyCaption = ""
                        toastViewModel.showToast(message: "Posted", status: .done)
                        try await feedViewModel.fetchThreads()
                    }
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 70, height: 34)
                        
                        Text("Post")
                            .bold()
                            .foregroundColor(Color(.systemBackground))
                    }
                }
                .disabled(replyCaption.isEmpty || loading == true)
                
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
    }
}

struct FeedReplyView_Preview: PreviewProvider {
    static var previews: some View {
        FeedReplyView(thread: dev.thread)
    }
}
