//
//  NotifyView.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//

import SwiftUI

struct NotifyView: View {
    let notifications: [Notification] // 假设通知数据是一个包含 Notification 对象的数组
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(notifications) { notification in
                        NotificationCardView(notification: notification)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("通知", displayMode: .inline)
    }
}

struct NotifyView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        NotifyView(
            notifications: Array(viewModel.notifications[0...2])
        )
        .environmentObject(viewModel)
    }
}

struct NotificationCardView: View {
    let notification: Notification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(notification.titlee)
                .font(.headline)
                .foregroundColor(.blue)
            Text(notification.content)
                .font(.body)
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
