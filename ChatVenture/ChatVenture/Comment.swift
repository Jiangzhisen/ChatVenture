//
//  Comment.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/31.
//

import Foundation

struct Comment: Codable, Identifiable {
    var id: String
    var commentuserid: String
    var commentcontent: String
}
