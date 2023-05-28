//
//  PostItem.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/5/28.
//

import SwiftUI

struct PostItem: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(post.userid)
                    .font(.subheadline)
                    .padding(8)
                Text(post.titlee)
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                Text(post.topic)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(8)
                Text("\(post.contentt)")
                    .font(.body)
                    .lineLimit(nil)
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(post.likes)")
                        .foregroundColor(.black)
                    Image(systemName: "message.fill")
                        .foregroundColor(.green)
                    Text("\(post.replies)")
                        .foregroundColor(.black)
                }
                .font(.caption)
                .padding(.top, 12)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
            .padding(.horizontal)        }
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        PostItem(post: viewModel.posts[0])
    }
}
