//
//  RegistrationView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullname: String = ""
    @State private var username: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer ()
            
            Image("threads-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .padding()
            
            VStack {
                TextField("Enter your email:", text: $email)
                    .autocapitalization(.none)
                    .modifier(TextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your full name:", text: $fullname)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your username:", text: $username)
                    .modifier(TextFieldModifier())
            }
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .modifier(ButtonModifier())
            }
            .padding(.vertical)
            Spacer()
            
            Divider()
            
            Button{
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(Color.primary)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
