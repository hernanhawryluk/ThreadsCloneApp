//
//  CreateThreadView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct CreateThreadView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption: String = ""
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: user, size: .small)
                    
                    VStack (alignment: .leading, spacing: 4) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        
                        TextField("What's new?", text: $caption, axis: .vertical)
                    }
                    
                    Spacer()
                    
                    if !caption.isEmpty{
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .font(.footnote)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("New thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadThread(caption: caption)
                            dismiss()
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    CreateThreadView()
}
