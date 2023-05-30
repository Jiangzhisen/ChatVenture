//
//  Post.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: String
    var userid: String
    var topic: String
    var titlee: String
    var contentt: String
    var likes: Int
    var replies: Int
    var comments: [Comment]
}
