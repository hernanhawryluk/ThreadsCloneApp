//
//  UserContentView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 22/08/2024.
//

import SwiftUI

struct UserContentListView: View {
    @StateObject var viewModel: UserContentListViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        } else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 1)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
        }
        LazyVStack {
            ForEach(viewModel.threads) { thread in
                    ThreadItemView(thread: thread)
            }
        }

    }
}

struct UserContentListView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentListView(user: dev.user)
    }
}
