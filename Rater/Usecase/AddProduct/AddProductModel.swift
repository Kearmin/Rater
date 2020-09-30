//
//  AddProductModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import UIKit
import Combine

class AddProductModel {
    
    let imageProvider: ImageProvider
    
    let productService = ProductService()
    
    
    init() {
        self.imageProvider = ImageProvider()
    }
    
    func createProduct(product: Product) -> AnyPublisher<Product, Error> {
        return productService.createProduct(product: product)
    }
    
    func saveImage(_ image: UIImage) -> AnyPublisher<URL, Error> {
        return ImageProvider.saveImage(image)
    }
}
