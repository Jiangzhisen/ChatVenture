//
//  PersonalView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//

import SwiftUI
import UIKit

struct PersonalView: View {
    @EnvironmentObject var viewModel: ChatVentureViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 30)
                
                if let userName = getUserName() {
                    Text("名稱: \(userName)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                } else {
                    Text("名稱: 未知")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                }
                
                Text("發布過的文章數: \(getUserPostCount())")
                    .font(.title2)
                    .padding(.bottom, 20)
                
                Text("發布過的留言數: \(getUserCommentCount())")
                    .font(.title2)
                    .padding(.bottom, 30)
                
                Button(action: {
                    logout()
                }) {
                    Text("登出")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            .navigationBarTitle("個人資料", displayMode: .inline)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
    
    func getUserName() -> String? {
        let userid = UserSingleton.shared.currentUser
        if let userName = viewModel.users.first(where: { $0.id == userid })?.userName {
            return userName
        }
        return nil
    }
    
    func getUserPostCount() -> Int {
        let userid = UserSingleton.shared.currentUser
        var userName1 = ""
        if let userName = viewModel.users.first(where: { $0.id == userid })?.userName {
            userName1 = userName
        }
        else {
            userName1 = ""
        }
        let postCount = viewModel.posts.filter({ $0.userid == userName1 }).count
        return postCount
    }
    
    func getUserCommentCount() -> Int {
        let userid = UserSingleton.shared.currentUser
        var userName1 = ""
        if let userName = viewModel.users.first(where: { $0.id == userid })?.userName {
            userName1 = userName
        }
        else {
            userName1 = ""
        }
        let commentCount = viewModel.posts.reduce(0) { result, post in
            result + post.comments.filter { $0.commentuserid == userName1 }.count
        }
        return commentCount
    }

    
    func logout() {
        UserSingleton.shared.currentUser = ""
        viewModel.isLoggingIn = false
    }

    
    
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        viewModel.users = [
            User(id: "M12345", userName: "zhisen", account: "admin", password: "admin")
        ]
        
        return PersonalView()
            .environmentObject(viewModel)
    }
}

