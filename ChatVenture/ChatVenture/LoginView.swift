//
//  LoginView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/29.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showErrorAlert = false
    
    let viewModel = ChatVentureViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("ChatVenture") // 加载图片文件
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding()
                
                TextField("account", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    // 在这里执行登录操作，比较用户名和密码是否匹配
                    if username == "admin" && password == "password" {
                        isLoggedIn = true
                    } else {
                        showErrorAlert = true
                    }
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: ContentView(posts: Array(viewModel.posts[0...3])), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.blue)
                                .shadow(color: .blue, radius: 3, x: 0, y: 2)
                        )
                }
                .padding()
            }
            .padding()
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("Invalid username or password. Please try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



