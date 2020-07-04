//
//  AddProductViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI

class AddProductViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var producer: String = ""
    @Published var description: String = ""
    @Published var productImage: Image = Image("E")
    
    private let addProductModel: AddProductModel
    
    func createNewItem(barcode: String) {
        
        let product = Product(name: name, id: ObjectContainer.sharedInstace.refIds.productId + 1, uploaderId: ObjectContainer.sharedInstace.user.id, producer: producer, description: description, imageUrl: nil, category: .undefined, price: nil, barcode: Int(barcode))
        
        self.addProductModel.createProduct(product: product)
        
        ObjectContainer.sharedInstace.refIds.productId += 1      
    }
    
    func takePicture() {
        print("take picture")
    }
    
    init(model: AddProductModel) {
        self.addProductModel = model
    }
}
