//
//  ContentView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

struct ContentView: View {
    let posts: [Post] // 帖子数组
    @State private var isPresentingNewPost = false
    @EnvironmentObject var viewModel: ChatVentureViewModel
    
    var body: some View {
        let userid = UserSingleton.shared.currentUser
        if viewModel.isLoggingIn {
            TabView {
                // 首页
                NavigationView {
                    PostListView(posts: viewModel.posts)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首頁")
                }
                .accentColor(.blue)
                
                // 追踪列表页
                NavigationView {
                    // ...
                }
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("追蹤列表")
                }
                .accentColor(.blue)
                
                // 通知页
                NavigationView {
                    NotifyView(notifications: viewModel.notifications)
                }
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("通知")
                }
                .accentColor(.blue)
                
                // 个人资料页
                NavigationView {
                    PersonalView()
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("個人資料")
                }
                .accentColor(.blue)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: EmptyView())
        }
        else {
            LoginView()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: EmptyView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        ContentView(
            posts: Array(viewModel.posts[0...4])
        )
        .environmentObject(viewModel)
    }
}

