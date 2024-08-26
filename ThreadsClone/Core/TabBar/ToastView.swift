//
//  ToastView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 25/08/2024.
//

import SwiftUI



struct ToastView: View {
    var show: Bool
    var message: String
    var status: ToastStatus
    
    var body: some View {
        if show {
            VStack{
                Spacer()
                
                HStack(spacing: 8) {
                    if status == .loading {
                        ProgressView()
                            .tint(.primary)
                    } else if status == .done {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal)
                .padding(.bottom, 30)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: status)
            }
        }
    }
}
