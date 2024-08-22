//
//  UserCell.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileImageView()
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)
            }
            .font(.footnote)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .frame(width: 100, height: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                            
                    }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell(user: User(id: "1", fullname: "Hernan Hawryluk", email: "hernan@gmail.com", username: "hernan_hawryluk"))
}

// // alternative preview using data from PreviewProvider
//struct UserCell_Preview: PreviewProvider {
//    static var previews: some View {
//        UserCell(user: dev.user)
//    }
//}
