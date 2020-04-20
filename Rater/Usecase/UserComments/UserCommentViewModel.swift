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
    
    var subscriptions = Set<AnyCancellable>()
    
    init(model: UserCommentModel, id: Int) {
        self.model = model
        self.id = id
        self.fetch()
    }
    
    func fetch() {
        
        let commentsPublisher = self.model.getComments(id: self.id)
            .map { $0.map { $0.text }}
            .eraseToAnyPublisher()
        
        self.model.getComments(id: self.id)
            .print("USERCOMMENTSPUBLISHER::")
            .tryMap { ratings -> AnyPublisher<[Product], Error> in
                
                if let firstt = ratings.first {
                    let firstPublisher = ProductPublisher.allProduct(id: firstt.productId, type: .productId).subject.eraseToAnyPublisher()
                    
                    _ = ratings.map { rating in
                        ProductPublisher.allProduct(id: rating.productId, type: .productId).subject.eraseToAnyPublisher().merge(with: firstPublisher)
                    }
                    
                    return firstPublisher
                } else {
                    throw AppError.undefined
                }
        }
        .switchToLatest()
        .collect(.byTime(DispatchQueue.main, .seconds(0.7)))
        .map { ratings -> [Product] in
            var toReturn = [Product]()
            _ = ratings.map { $0.map{ toReturn.append($0) }}
            return toReturn
        }
        .zip(commentsPublisher)
        .map {
            let arrays = zip($0.0, $0.1)
            return arrays.map { UserCommentRowContent(image: Image("E"), productName: $0.0.name, commentText: $0.1) }
        }
        .sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: {
            self.userCommentRows = $0
        })
        .store(in: &subscriptions)
    }
}
