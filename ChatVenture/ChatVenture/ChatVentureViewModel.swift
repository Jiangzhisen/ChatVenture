//
//  ChatVentureViewModel.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import Foundation

class ChatVentureViewModel: ObservableObject {
    @Published var posts: [Post] = [] // 初始化为空数组
    @Published var users: [User] = []
    @Published var notifications: [Notification] = []
    @Published var isLoggingIn: Bool = false
    @Published var board : [Board] = []
    
    init() {
        self.loadPosts("ChatVentureData.json") // 在初始化器中调用加载数据的方法
        self.loadUsers("user.json")
        self.loadNotify("notify.json")
        self.loadBoard("board.json")

    }
    
    func loadPosts(_ filename: String) {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            self.posts = try decoder.decode([Post].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([Post].self):\n\(error)")
        }
    }
    
    func loadBoard(_ filename: String) {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            self.board = try decoder.decode([Board].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([Board].self):\n\(error)")
        }
    }

    
    func loadUsers(_ filename: String) {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            self.users = try decoder.decode([User].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([User].self):\n\(error)")
        }
    }
    
    func loadNotify(_ filename: String) {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            self.notifications = try decoder.decode([Notification].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([Notification].self):\n\(error)")
        }
        
    }
    
    
    
    func addComment(to postID: String, comment: Comment) {
        if let index = posts.firstIndex(where: { $0.id == postID }) {
            posts[index].comments.append(comment)
            let filePath = "/Users/zhongyuanziguan/Desktop/10944128/FinalProject/ChatVenture/ChatVenture/ChatVentureData.json"
            let fileURL = URL(fileURLWithPath: filePath)
            
            do {
                let jsonData = try JSONEncoder().encode(posts)
                try jsonData.write(to: fileURL)
            } catch {
                print("无法写入JSON数据：\(error)")
            }
        }
    }
    
    func addPost(post: Post) {
        posts.append(post)
        let filePath = "/Users/zhongyuanziguan/Desktop/10944128/FinalProject/ChatVenture/ChatVenture/ChatVentureData.json"
        let fileURL = URL(fileURLWithPath: filePath)
        
        do {
            let jsonData = try JSONEncoder().encode(posts)
            try jsonData.write(to: fileURL)
        } catch {
            print("无法写入JSON数据：\(error)")
        }
    }
    
    func updateLikes(for postID: String, newLikesCount: Int, newLikesStatus: Bool) {
        if let index = posts.firstIndex(where: { $0.id == postID }) {
            posts[index].likes = newLikesCount
            posts[index].islike = newLikesStatus
        }
        
        let filePath = "/Users/zhongyuanziguan/Desktop/10944128/FinalProject/ChatVenture/ChatVenture/ChatVentureData.json"
        let fileURL = URL(fileURLWithPath: filePath)
        
        do {
            let jsonData = try JSONEncoder().encode(posts)
            try jsonData.write(to: fileURL)
        } catch {
            print("无法写入JSON数据：\(error)")
        }
    }
    
}


class UserSingleton {
    static let shared = UserSingleton()
    var currentUser: String = ""
    private init() {}
}

