//
//  AddProductFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class AddProducrFactory {
    static func createAddProduct() -> AddProductView {
        
        
        let model = AddProductModel()
        let viewModel = AddProductViewModel(model: model)
        return  AddProductView(viewModel: viewModel)
    }
}
