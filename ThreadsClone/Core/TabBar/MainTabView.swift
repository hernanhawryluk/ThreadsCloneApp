//
//  TabView.swift
//  ThreadsClone
//
//  Created by Hernan Hawryluk on 20/08/2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var lastSelectedTab: Int = 0
    
    @StateObject private var createThreadSheetManager = CreateThreadSheetManager()
    @StateObject private var feedViewModel = FeedViewModel()
    @StateObject private var currentUserProfileViewModel = CurrentUserProfileViewModel()
    @StateObject private var toastViewModel = ToastViewModel()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        .foregroundColor(selectedTab == 0 ? .red : .green)
                }
                .onAppear {
                    selectedTab = 0
                    lastSelectedTab = 0
                }
                .tag(0)
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear {
                    selectedTab = 1
                    lastSelectedTab = 1
                }
                .tag(1)
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear {
                    selectedTab = lastSelectedTab
                    createThreadSheetManager.show = true
                }
                .tag(2)
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                        .foregroundColor(selectedTab == 3 ? .red : .green)
                }
                .onAppear { 
                    selectedTab = 3
                    lastSelectedTab = 3
                }
                .tag(3)
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                        .foregroundColor(selectedTab == 4 ? .red : .green)
                }
                .onAppear { 
                    selectedTab = 4
                    lastSelectedTab = 4
                }
                .tag(4)
        }
        .environmentObject(createThreadSheetManager)
        .environmentObject(feedViewModel)
        .environmentObject(currentUserProfileViewModel)
        .environmentObject(toastViewModel)
        .tint(Color.primary)
        .sheet(isPresented: $createThreadSheetManager.show, onDismiss: {
            selectedTab = lastSelectedTab
        }, content: {
            CreateThreadView()
        })
        .overlay(
            withAnimation{
                ToastView(show: toastViewModel.show, message: toastViewModel.message, status: toastViewModel.status)
            }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: toastViewModel.show)
        )
    }
}

#Preview {
    MainTabView()
}
