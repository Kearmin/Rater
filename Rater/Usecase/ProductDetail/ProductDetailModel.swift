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
    let productService = ProductService()
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func load() -> AnyPublisher<ProductDetail, Error> {
        return productService.getProduct(id: productId)
    }
}
