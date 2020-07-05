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
    
    let provider: FirebaseWriteOperations
    let imageProvider: ImageProvider
    
    init() {
        self.provider = FirebaseWriteOperations(databaseReference: ObjectContainer.sharedInstace.dbReference)
        self.imageProvider = ImageProvider()
    }
    
    func createProduct(product: Product) {
        self.provider.createProduct(product: product)
    }
    
    func saveImage(_ image: UIImage) -> AnyPublisher<URL, AppError> {
        return ImageProvider.saveImage(image)
    }
    
}
