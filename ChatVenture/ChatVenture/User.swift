//
//  User.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/30.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var userName: String
    var account: String
    var password: String
}
