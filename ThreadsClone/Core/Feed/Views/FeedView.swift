//
//  FeedView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0...10, id: \.self) { thread in
                        ThreadCell()
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refreshing threads...")
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
