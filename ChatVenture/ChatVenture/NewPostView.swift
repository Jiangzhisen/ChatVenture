//
//  NewPostView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

struct NewPostView: View {
    @State private var username = ""
    @State private var topic = ""
    @State private var title = ""
    @State private var content = ""
    
    @EnvironmentObject private var viewModel: ChatVentureViewModel
    
    @State private var isPostSubmitted = false // 新增的状态属性
    
    @Environment(\.presentationMode) var presentationMode
    
    // 用于保存新帖子的数组属性
    //@State private var newPosts: [Post] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("標題", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("主題", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextEditor(text: $content)
                    .frame(height: 150)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button(action: {
                    submitPost()
                }) {
                    Text("送出")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                // 成功提示画面
                if isPostSubmitted {
                    Text("成功提交！")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isPostSubmitted = false // 2秒后隐藏提示画面
                            }
                        }
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            .padding()
            .navigationBarItems(trailing:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("返回")
                }
            )
            .navigationBarTitle("新增貼文", displayMode: .inline)
        }
    }
    
    
    func submitPost() {
        // 在这里执行提交操作，可以使用 username、topic、title 和 content 属性的值
        // 根据需要执行适当的操作，比如创建新的帖子对象，并将其添加到数据源中
        // 示例：创建一个新的 Post 对象并执行保存操作
        
        let userid = UserSingleton.shared.currentUser
        
        let userName = viewModel.users.first(where: { $0.id == userid })
        let userName1 = userName?.userName
        
        let newPost = Post(
            id: UUID().uuidString,
            userid: userName1!,
            topic: topic,
            titlee: title,
            contentt: content,
            likes: 0,
            replies: 0,
            comments: [],
            islike: false
        )
        
        // 将新帖子添加到数组中
        viewModel.addPost(post: newPost)
        
        presentationMode.wrappedValue.dismiss()
        
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
            .environmentObject(ChatVentureViewModel())
    }
}

