//
//  UserCommentsView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct UserCommentsView: View {
    
    @ObservedObject var viewModel: UserCommentViewModel
    
    init(viewModel: UserCommentViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        List {
            ForEach(self.viewModel.userCommentRows) { row in
                UserCommentRow(content: row)
                    .padding()
            }
        }
        .padding(.all, 2.0)
        .onAppear(perform: {
            self.viewModel.fetch()
        })
    }
}

struct UserCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        UserCommentsView(viewModel: UserCommentViewModel(model: UserCommentModel(), id: 0, userName: "Jenci"))
    }
}
