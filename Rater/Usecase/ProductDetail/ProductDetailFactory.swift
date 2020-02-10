//
//  ProductDetailFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 08..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation


class ProductDetailFactory {
    
    static func createProductDetail(with id: Int) -> ProductDetailView {
        
        let model = ProductDetailModel(productId: id)
        let viewModel = ProductDetailViewModel(productId: id, productDetailModel: model)
        let view = ProductDetailView(viewModel: viewModel)
        
        return view
    }
}
