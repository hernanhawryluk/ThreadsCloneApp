//
//  EditProfileView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 21/08/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    
    @State private var bio: String = ""
    @State private var link: String = ""
    @State private var isPrivateProfile: Bool = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(Color(.systemGroupedBackground))
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text("Hernan Hawryluk")
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user, size: .small)
                            }
                        }
                        .onAppear {
                            requestPhotoLibraryAccess()
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        
                        VStack(alignment: .leading) {
                            Text("Bio")
                                .fontWeight(.semibold)
                            
                            TextField("+ Write bio", text: $bio, axis: .vertical)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        
                        VStack(alignment: .leading) {
                            Text("Link")
                                .fontWeight(.semibold)
                            
                            TextField("+ Add link", text: $link)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        
                        VStack(alignment: .leading) {
                            Text("Private profile")
                                .fontWeight(.semibold)
                            
                            Text("Private profiles can only reply to their followers. Switch to public to reply to anyone.")
                                .foregroundColor(Color.secondary)
                        }
                        
                        Toggle("", isOn: $isPrivateProfile)
                            .frame(width: 80)
                    }
                }
                .font(.footnote)
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
            }
            .navigationTitle("Edit profile")
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
                    Button("Done") {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    print("Access granted")
                } else {
                    print("Access denied")
                }
            }
        }
    }
}

struct EditProfileView_Preview: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: dev.user)
    }
}
