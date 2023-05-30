//
//  PostItem.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

struct PostItem: View {
    let post: Post
    @State private var commentText = ""
    @State private var comments: [Comment] = [] // 存储评论的数组
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(post.userid)
                    .font(.subheadline)
                    .padding(8)
                Text(post.titlee)
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                Text(post.topic)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(8)
                Text("\(post.contentt)")
                    .font(.body)
                    .lineLimit(nil)
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(post.likes)")
                        .foregroundColor(.black)
                    Image(systemName: "message.fill")
                        .foregroundColor(.green)
                    Text("\(post.replies)")
                        .foregroundColor(.black)
                }
                .font(.caption)
                .padding(.top, 12)
                
                Spacer()
                
                HStack {
                    ZStack(alignment: .leading) {
                        if commentText.isEmpty {
                            Text("撰寫留言...")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                        
                        TextEditor(text: $commentText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {
                        // 在此处执行提交评论的操作
                        submitComment()
                        commentText = ""
                    }) {
                        Text("提交")
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(commentText.isEmpty) // 当输入框为空时禁用按钮
                }
                
                
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
    
    func submitComment() {
        // 执行提交评论的逻辑
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        PostItem(post: viewModel.posts[0])
    }
}
