//
//  ProductDetailModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class ProductDetailModel {
    
    let productId: Int
    var subscriptions = Set<AnyCancellable>()
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func getAverage() -> AnyPublisher<Double, Error> {
        
        return RatingPublisher.averageRating(for: self.productId).subject
        .print("AVERAGEPUBLISHER")
        .eraseToAnyPublisher()
        
    }
    
    func getProduct() -> AnyPublisher<Product?, Error> {
        
        return ProductPublisher.allProduct(id: self.productId, type: .productId).subject
        .print("PRODUCTPUBLISHER")
        .map { products -> Product? in
                products.first
        }
         .eraseToAnyPublisher()
    }
    
    func getRatings() -> AnyPublisher<[Rating], Error> {
        
        return RatingPublisher.allRating(for: self.productId, type: .productId).subject
        .print("RATINGPUBLISHER")
        .eraseToAnyPublisher()
    }
}
