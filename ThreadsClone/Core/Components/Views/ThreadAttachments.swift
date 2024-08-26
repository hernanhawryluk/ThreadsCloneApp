//
//  ThreadAttachments.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import SwiftUI

struct ThreadAttachments: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .frame(width: 26)
            
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width: 24)
            
            Image(systemName: "rectangle.and.paperclip")
                .resizable()
                .scaledToFit()
                .frame(width: 25)
            
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .frame(width: 14)
            
            Image(systemName: "number")
                .resizable()
                .scaledToFit()
                .frame(width: 16)
            
            Image(systemName: "scroll")
                .resizable()
                .scaledToFit()
                .frame(width: 16)
        }.padding(8)
    }
}

#Preview {
    ThreadAttachments()
}
