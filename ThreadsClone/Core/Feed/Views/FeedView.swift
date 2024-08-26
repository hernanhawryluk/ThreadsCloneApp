//
//  FeedView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @EnvironmentObject var userViewModel: CurrentUserProfileViewModel
    @EnvironmentObject var createThreadSheetManager: CreateThreadSheetManager
    
    private var currentUser: User? {
        return userViewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("threads-app-icon")
                        .resizable()
                        .frame(width: 38, height: 38)
                    
                    HStack(alignment: .top, spacing: 12) {
                        CircularProfileImageView(user: currentUser, size: .small)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(currentUser?.username ?? "")
                                .fontWeight(.semibold)
                            
                            Button {
                                createThreadSheetManager.show = true
                            } label: {
                                Text("What's new?")
                            }
                            
                            ThreadAttachments()
                            
                        }
                        .font(.footnote)
                        .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    .padding(.top, 16)
                    
                    Divider()
                }
                
                LazyVStack {
                    ForEach(viewModel.threads.indices, id: \.self) { index in
                        let thread = viewModel.threads[index]
                        
                        ThreadItemView(thread: thread)
                            .onAppear() {
                                if index == viewModel.threads.count - 1 {
                                    Task {
                                        try await viewModel.fetchMoreThreads()
                                    }
                                }
                            }
                    }
                    
                    if viewModel.loading {
                        ProgressView()
                            .padding()
                    }
                }
            }
            .padding(.horizontal)
            .refreshable {
                Task { try await viewModel.fetchThreads() }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
