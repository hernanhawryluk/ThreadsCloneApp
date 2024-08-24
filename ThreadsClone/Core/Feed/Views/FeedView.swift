//
//  FeedView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        ThreadItemView(thread: thread)
                    }
                }
            }
            .refreshable {
                Task { try await viewModel.fetchThreads() }
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(Color.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
