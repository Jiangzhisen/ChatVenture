//
//  PostListView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//

import SwiftUI

import SwiftUI

struct PostListView: View {
    let posts: [Post] // 帖子数组
    @State private var isPresentingNewPost = false
    @EnvironmentObject var viewModel: ChatVentureViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.posts) { post in
                NavigationLink(destination: PostItem(post: post)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.topic)
                            .font(.subheadline)
                            .foregroundColor(.orange)
                            .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
                        Text(post.titlee)
                            .font(.headline)
                            .foregroundColor(.blue)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading) // 左对齐
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("\(post.likes)")
                                .foregroundColor(.black)
                            Image(systemName: "bubble.right.fill")
                                .foregroundColor(.green)
                            Text("\(post.replies)")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                }
            }
            .navigationTitle("首頁")
            .navigationBarItems(trailing:
                Button(action: {
                    isPresentingNewPost = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
                .sheet(isPresented: $isPresentingNewPost) {
                    // 这里是新增贴文页面的视图
                    NewPostView()
                }
            )
        }
        .navigationBarTitle("首頁", displayMode: .inline)
    }
}


struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        ContentView(
            posts: Array(viewModel.posts[0...4])
        )
        .environmentObject(viewModel)
    }
}
