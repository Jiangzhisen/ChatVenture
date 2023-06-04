//
//  Notify.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//

import Foundation

struct Notification: Codable, Identifiable {
    let id: String
    let userid: String
    let titlee: String
    let content: String
}
