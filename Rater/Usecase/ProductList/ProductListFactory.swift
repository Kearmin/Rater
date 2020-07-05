//
//  ProductListFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI

class ProductListFactory {
    
    static func createProductList() -> some View {
        
        let scannerData = ScannerFlowData()
        let model = ProductListModel()
        let viewModel = ProductListViewModel(model: model, scannerData: scannerData)
        let view = ProductListView(viewModel: viewModel).environmentObject(scannerData)
        
        return view
    }
    
}
