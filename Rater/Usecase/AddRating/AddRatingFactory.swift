//
//  AddRatingFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI

class AddRatingFactory {
    
    static func createAddRating(productId: Int) -> some View {
        
        let model = AddRatingModel()
        let viewModel = AddRatingViewModel(model: model, productId: productId)
        let view = AddRatingView(viewModel: viewModel)
        
        return view
    }
    
}
