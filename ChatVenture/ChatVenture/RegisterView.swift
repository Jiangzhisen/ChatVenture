//
//  RegisterView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/29.
//

import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var account = ""
    @State private var password = ""
    @State private var showSuccessAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: ChatVentureViewModel
    //@Binding var isRegistered: Bool
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Account", text: $account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                registerUser()
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Registration Successful"),
                message: Text("Congratulations! You have successfully registered."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss() // 返回登录页面
                    //isRegistered = true // 标记为已注册，触发导航链接返回到LoginView
                }
            )
        }
    }
    
    func registerUser() {
        // 创建 User 对象
        let newUser = User(
            id: "M23456",
            userName: username,
            account: account,
            password: password
        )
        
        viewModel.users.append(newUser)
            
        // 将 JSON 数据写入文件
        let filePath = "/Users/zhongyuanziguan/Desktop/10944128/FinalProject/ChatVenture/ChatVenture/user.json"
        let fileURL = URL(fileURLWithPath: filePath)
        
        do {
            let jsonData = try JSONEncoder().encode(viewModel.users)
            try jsonData.write(to: fileURL)
            showSuccessAlert = true // 显示注册成功的通知
        } catch {
            print("无法写入JSON数据：\(error)")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

