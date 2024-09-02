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
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16)
                        .foregroundColor(thread.currentUserHasLiked == true ? .red : .primary)
                        .animation(.easeInOut, value: thread.currentUserHasLiked)
                    
                    if thread.likes > 0 {
                        Text("\(thread.likes)")
                            .font(.footnote)
                            .animation(.easeInOut, value: thread.likes)
                    }
                }.padding(.bottom, 2)
            }
            
            Button {
                showReplySheet.toggle()
            } label: {
                HStack {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16)
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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17)
                    .padding(.bottom, 2)
                    
            }
            
            Button {
                
            } label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14)
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
