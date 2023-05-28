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
    
    @State private var isPostSubmitted = false // 新增的状态属性
    
    @Environment(\.presentationMode) var presentationMode
    
    // 用于保存新帖子的数组属性
    @State private var newPosts: [Post] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("使用者名稱", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("主題", text: $topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("標題", text: $title)
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
        let newPost = Post(
            id: UUID().uuidString,
            userid: username,
            topic: topic,
            titlee: title,
            contentt: content,
            likes: 0,
            replies: 0
        )
        
        // 将新帖子添加到数组中
        newPosts.append(newPost)
        
        // 将新帖子数组编码为JSON数据
        if let jsonData = try? JSONEncoder().encode(newPosts) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                // 将JSON数据写入ChatVentureData.json文件
                if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ChatVentureData.json") {
                    do {
                        try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                        // 成功写入JSON数据后，可以执行其他操作，如关闭界面或显示成功提示等
                        // 成功写入JSON数据后，显示成功提示画面
                        isPostSubmitted = true
                    } catch {
                        print("无法写入JSON数据：\(error)")
                    }
                }
            }
        }
        
        // 关闭新帖子界面
        presentationMode.wrappedValue.dismiss()

    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

