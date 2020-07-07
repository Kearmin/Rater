//
//  UserCommentFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class UserCommentFactory {
    static func createUserComment(id: Int, userName: String) -> UserCommentsView {
        
        
        let model = UserCommentModel()
        let viewModel = UserCommentViewModel(model: model, id: id, userName: userName)
        return  UserCommentsView(viewModel: viewModel)
    }
}
