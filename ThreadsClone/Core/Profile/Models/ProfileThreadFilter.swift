//
//  ProfileThreadFilter.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies
    case reposts
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        case .reposts: return "Reposts"
        }
    }
    
    var id: Int { return self.rawValue }
}
