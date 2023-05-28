//
//  ChatVentureApp.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

@main
struct ChatVentureApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ChatVentureViewModel()
            ContentView(
                posts: Array(viewModel.posts[0...2])
            )
        }
    }
}
