//
//  PostItem.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

struct PostItem: View {
    var post: Post
    @State private var commentText = ""
    @EnvironmentObject private var viewModel: ChatVentureViewModel
    @State private var likes1: Int = 0
    
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
                    Button(action: {
                        toggleLike()
                    }) {
                        Image(systemName: post.islike ? "heart.fill" : "heart")
                            .foregroundColor(post.islike ? .red : .black)
                    }
                    Text("\(post.likes)")
                        .foregroundColor(.black)
    
                    Image(systemName: "message.fill")
                        .foregroundColor(.green)
                    Text("\(post.comments.count)")
                        .foregroundColor(.black)
                }
                .font(.title)
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
                
                Spacer()
                
                // 评论区域
                HStack {
                    Text("評論數: (\(post.comments.count))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                }
                ForEach(post.comments) { comment in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(comment.commentuserid)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text(comment.commentcontent)
                            .font(.body)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.bottom, 8)
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
        let userid = UserSingleton.shared.currentUser
        
        let userName = viewModel.users.first(where: { $0.id == userid })
        let userName1 = userName?.userName
        
        print("userid: \(userName)")
        
        let newComment = Comment(
            id: UUID().uuidString,
            commentuserid: userName1!,
            commentcontent: commentText
        )
        
        let postID = post.id
        viewModel.addComment(to: postID, comment: newComment)
        
        // 清空评论输入框
        commentText = ""
    }
    
    func toggleLike() {
        
        if post.islike {
            viewModel.updateLikes(for: post.id, newLikesCount: post.likes - 1, newLikesStatus: !post.islike)
        } else {
            viewModel.updateLikes(for: post.id, newLikesCount: post.likes + 1, newLikesStatus: !post.islike)
        }
    }
    
}


struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        PostItem(post: viewModel.posts[0])
    }
}
