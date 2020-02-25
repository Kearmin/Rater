//
//  ProductListModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Combine

class ProductListModel {
    
    func getAllProducts() -> AnyPublisher<[Product], Error> {
        
        let productPublisher = ProductPublisher.allProduct(id: nil, type: .productId).subject
        
        return productPublisher
            .share()
            .eraseToAnyPublisher()
    }
}
