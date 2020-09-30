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
    
    let pageService = PageService()
    var afterId: Int?
    var shouldLoad = true
    
    func getAllProducts(searchString: String? = nil) -> AnyPublisher<[Product], Error> {
        
        if shouldLoad == false {
            return Just<[Product]>([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        
        return pageService.getAllProduct(searchText: searchString, afterId: afterId, userId: nil)
            .map { products -> [Product] in
                if let last = products.last {
                    self.afterId = last.id
                }
                return products
            }
            .map { products in
                if products.isEmpty == true {
                    self.shouldLoad = false
                }
                return products
            }
            .eraseToAnyPublisher()
    }
}
