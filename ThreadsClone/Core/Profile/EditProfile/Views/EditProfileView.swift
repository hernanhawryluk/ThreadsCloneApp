//
//  EditProfileView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 21/08/2024.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bio: String = ""
    @State private var link: String = ""
    @State private var isPrivateProfile: Bool = false
    
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
                        
                        CircularProfileImageView()
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
                        
                    }
                    .font(.subheadline)
                    .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    EditProfileView()
}
