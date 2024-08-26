//
//  ThreadItemButtonsView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 24/08/2024.
//

import SwiftUI

struct ThreadItemButtonsView: View {
    let thread: Thread

    @State private var showReplySheet: Bool = false
    @EnvironmentObject var viewModel: FeedViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                Task {
                    try await viewModel.likeThread(thread: thread)
                }
            } label: {
                HStack{
                    
                    Image(systemName: thread.currentUserHasLiked == true ? "heart.fill" : "heart")
                        .foregroundColor(thread.currentUserHasLiked == true ? .red : .primary)
                        .animation(.easeInOut, value: thread.currentUserHasLiked)
                    
                    if thread.likes > 0 {
                        Text("\(thread.likes)")
                            .font(.footnote)
                            .animation(.easeInOut, value: thread.likes)
                    }
                }
            }
            
            Button {
                showReplySheet.toggle()
            } label: {
                HStack {
                    Image(systemName: "bubble.right")
                    if thread.replies > 0 {
                        Text("\(thread.replies)")
                            .font(.footnote)
                            .animation(.easeInOut, value: thread.replies)
                    }
                }
            }
            
            Button {
                
            } label: {
                Image(systemName: "arrow.rectanglepath")
            }
            
            Button {
                
            } label: {
                Image(systemName: "paperplane")
            }
            
        }
        .foregroundColor(Color.primary)
        .padding(.vertical, 8)
        .sheet(isPresented: $showReplySheet, content: {
            FeedReplyView(thread: thread)
        })
    }
}

struct ThreadItemButtonsView_preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ThreadItemButtonsView(thread: dev.thread)

        }
    }
}
