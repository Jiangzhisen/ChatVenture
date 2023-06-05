//
//  boardRow.swift
//  ChatVenture
//
//  Created by 中原資管 on 2023/6/4.
//

import SwiftUI

struct BoardRow: View {
    var board : Board
    var body: some View {
        
            HStack{
                
                Spacer()
                    .frame(width: 30)
                Image(systemName: board.Img)
                
                
                Spacer()
                
                Text(board.bName)
                
                Spacer()
                
                
                Spacer()
                    .frame(width: 30)
            }
            
        .frame(height: 80)
            .padding(.top,0)
        
    }
        
}
    

struct BoardRow_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChatVentureViewModel()
        BoardRow(board:viewModel.board[0])
                    .previewLayout(.fixed(width: 300, height: 70))
       
    }
}


