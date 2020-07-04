//
//  AddProductModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class AddProductModel {
    
    let provider: FirebaseWriteOperations
    
    init() {
        self.provider = FirebaseWriteOperations(databaseReference: ObjectContainer.sharedInstace.dbReference)
    }
    
    func createProduct(product: Product) {
        self.provider.createProduct(product: product)
    }
}
