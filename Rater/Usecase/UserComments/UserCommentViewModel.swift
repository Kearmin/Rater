//
//  UserCommentViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 03. 13..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserCommentViewModel: ObservableObject {
    
    @Published var userCommentRows = [UserCommentRowContent]()
    @Published var refresh = "false"
    
    let model: UserCommentModel
    let id: Int
    let commenterId: Int
    let userName: String
    
    var subscriptions = Set<AnyCancellable>()
    
    init(model: UserCommentModel, id: Int, userName: String, commenterId: Int) {
        self.model = model
        self.id = id
        self.userName = userName
        self.commenterId = commenterId
        self.load()
    }
    
    func load() {
        model.load(id: commenterId)
            .map { comments in
                return comments.map { comment in
                    UserCommentRowContent(id: comment.id, imageUrl: comment.productImageUrl, productName: comment.productName, commentText: comment.text, rating: comment.rating)
                }
            }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { result in
            print(result)
        }) { content in
            self.userCommentRows = content
        }
        .store(in: &subscriptions)
    }
}
