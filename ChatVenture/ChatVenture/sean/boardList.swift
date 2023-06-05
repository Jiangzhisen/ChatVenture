//
//  boardList.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//


import SwiftUI



struct boardList: View {
     var viewModel2: ChatVentureViewModel
    var boards :[Board]


    var body: some View {
        
        
        VStack(alignment: .leading) {
            NavigationStack{
                List{
                    ForEach(boards) { board in
                        NavigationLink{
                            PostListView2(posts: viewModel2.posts, nowTpoic2: board.bName)
                        }label: {
                            BoardRow(board: board)
                        }
                    }
                    
                }
                
            }
            .navigationTitle("看板")
        }
            
    }
}





