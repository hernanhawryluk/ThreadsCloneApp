//
//  ThreadCell.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct ThreadItemView: View {
    let thread: Thread
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top, spacing: 12) {
                    CircularProfileImageView(user: thread.user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            
                            if let user = thread.user{
                                NavigationLink(destination: ProfileView(user: user)) {
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
                        
                        Text(thread.caption)
                            .font(.footnote)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                        ThreadItemButtonsView(thread: thread)
                    }
                }
                Divider()
            }
            .padding()
        }
        
    }
}

struct ThreadCell_Preview: PreviewProvider {
    static var previews: some View {
        ThreadItemView(thread: dev.thread)
    }
}
