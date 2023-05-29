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
    
    var body: some View {
            NavigationView {
                List(posts, id: \.id) { post in
                    NavigationLink(destination: PostItem(post: post)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.topic)
                                .font(.subheadline)
                                .foregroundColor(.orange)
                            Text(post.titlee)
                                .font(.headline)
                                .foregroundColor(.blue)
                                .lineLimit(2)
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
                        //.shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                    }
                }
                .navigationTitle("貼文列表")
                .navigationBarItems(trailing:
                    Button(action: {
                        isPresentingNewPost = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    .sheet(isPresented: $isPresentingNewPost) {
                        // 这里是新增贴文页面的视图
                        NewPostView()
                    }
                )
            }
        }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        ContentView(
            posts: Array(viewModel.posts[0...3])	
        )
        .environmentObject(viewModel)
    }
}
