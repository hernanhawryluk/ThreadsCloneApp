//
//  UserCell.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            CircularProfileImageView()
            
            VStack(alignment: .leading) {
                Text("hernanhawryluk")
                    .fontWeight(.semibold)
                
                Text("Hernan Hawryluk")
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
    UserCell()
}
