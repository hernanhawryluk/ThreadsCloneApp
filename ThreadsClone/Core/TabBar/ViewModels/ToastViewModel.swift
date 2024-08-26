//
//  ToastViewModel.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 26/08/2024.
//

import Foundation

enum ToastStatus {
    case loading
    case done
}

class ToastViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var status: ToastStatus = .done
    @Published var show: Bool = false

    @MainActor
    func showToast(message: String, status: ToastStatus) {
        self.message = message
        self.status = status
        self.show = true
        
        if status != .loading {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.show = false
            }
        }
    }
}

