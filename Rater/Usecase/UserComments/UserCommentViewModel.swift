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
    
    @Published var commenterId: Int = -1
    
    let model: UserCommentModel
    let id: Int
    let userName: String
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var products: [Product] = []
    @Published var ratings: [Rating] = []
    
    init(model: UserCommentModel, id: Int, userName: String) {
        self.model = model
        self.id = id
        self.userName = userName
        self.fetch()
    }
    
    func fetch() {
        
        self.model.getId(for: self.userName)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }) { id in
                self.commenterId = id
        }
        .store(in: &subscriptions)
        
        $commenterId
            .drop { (id) -> Bool in return (id < 0) }
            .map { id -> AnyPublisher<[Product], Error> in
                return ProductPublisher.allProduct(id: nil, type: .uploaderId).subject.eraseToAnyPublisher()
        }
        .setFailureType(to: Error.self)
        .switchToLatest()
        .sink(receiveCompletion: { (completion) in
            print(completion)
        }) { products in
            self.products = products
        }
        .store(in: &subscriptions)
        
        $commenterId
            .drop { (id) -> Bool in return (id < 0) }
            .map { id in
                return RatingPublisher.allRating(for: id, type: .uploaderId).subject.eraseToAnyPublisher()
        }
        .setFailureType(to: Error.self)
        .switchToLatest()
        .sink(receiveCompletion: { (completion) in
            print(completion)
        }) { ratings in
            self.ratings = ratings
        }
        .store(in: &subscriptions)
        
        $ratings
            .sink { _ in
                if self.ratings.isEmpty || self.products.isEmpty {
                    return
                } else {
                    
                    var content = [UserCommentRowContent]()
                    
                    for rating in self.ratings {
                        for product in self.products {
                            if product.id == rating.productId {
                                content.append(UserCommentRowContent(imageUrl: product.imageUrl, productName: product.name, commentText: rating.text, rating: rating.rating))
                            }
                        }
                    }
                    self.userCommentRows = content
                }
        }
        .store(in: &subscriptions)
        
        $products
            .sink { _ in
                if self.ratings.isEmpty || self.products.isEmpty {
                    
                    return
                } else {
                    
                    var content = [UserCommentRowContent]()
                    
                    for rating in self.ratings {
                        for product in self.products {
                            if product.id == rating.productId {
                                content.append(UserCommentRowContent(imageUrl: product.imageUrl, productName: product.name, commentText: rating.text, rating: rating.rating))
                            }
                        }
                    }
                    self.userCommentRows = content
                }
        }
        .store(in: &subscriptions)
        
        //        let commentsPublisher = self.model.getComments(id: self.id)
        //            .eraseToAnyPublisher()
        
        //        self.model.getComments(id: self.id)
        //            .print("GETCOMMENTS::")
        //            .tryMap { ratings -> AnyPublisher<[Product], Error> in
        //
        //                if ratings.first != nil {
        //                    let firstPublisher = ProductPublisher.allProduct(id: self.commenterId, type: .uploaderId).subject.eraseToAnyPublisher()
        //
        //                    return firstPublisher
        //                } else {
        //                    throw AppError.undefined
        //                }
        //        }
        //        .switchToLatest()
        //        .collect(.byTime(DispatchQueue.main, .seconds(0.7)))
        //        .map { ratings -> [Product] in
        //            var toReturn = [Product]()
        //            _ = ratings.map { $0.map{ toReturn.append($0) }}
        //            return toReturn
        //        }
        //        .zip(commentsPublisher)
        //        .map {
        //            let arrays = zip($0.0, $0.1)
        //            return arrays.map { UserCommentRowContent(imageUrl: $0.0.imageUrl, productName: $0.0.name, commentText: $0.1.text, rating: $0.1.rating) }
        //        }
        //        .sink(receiveCompletion: { completion in
        //            print(completion)
        //        }, receiveValue: {
        //            self.userCommentRows = $0
        //        })
        //        .store(in: &subscriptions)
    }
}
