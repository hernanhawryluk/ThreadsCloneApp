//
//  RegistrationView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var loader: Bool = false
    
    var body: some View {
        VStack {
            Spacer ()
            
            Image("threads-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .padding()
            
            VStack {
                TextField("Enter your email:", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(TextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your full name:", text: $viewModel.fullname)
                    .modifier(TextFieldModifier())
                
                TextField("Enter your username:", text: $viewModel.username)
                    .autocapitalization(.none)
                    .modifier(TextFieldModifier())
                    
            }
            
            Button {
                Task {
                    loader = true
                    try await viewModel.createUser()
                    loader = false
                }
            } label: {
                if (!loader){
                    Text("Sign Up")
                        .modifier(ButtonModifier())
                } else {
                    ProgressView()
                }
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
