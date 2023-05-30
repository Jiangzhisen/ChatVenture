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
    
    init() {
        self.loadPosts("ChatVentureData.json") // 在初始化器中调用加载数据的方法
        self.loadUsers("user.json")
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
    
}

