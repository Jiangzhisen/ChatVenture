//
//  ChatVentureApp.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

@main
struct ChatVentureApp: App {
    @StateObject private var viewModel = ChatVentureViewModel() // 创建 ChatVentureViewModel 的实例，并使用 @StateObject 标记
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
