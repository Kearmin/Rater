//
//  ProductListFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation

class ProductListFactory {
    
    static func createProductList() -> ProductListView {
        
        let model = ProductListModel()
        let viewModel = ProductListViewModel(model: model)
        let view = ProductListView(viewModel: viewModel)
        
        return view
    }
    
}
