//
//  AddProductFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI

class AddProducrFactory {
    static func createAddProduct() -> some View {
        
        let flowData = ScannerFlowData()
        let model = AddProductModel()
        let viewModel = AddProductViewModel(model: model, flowData: flowData)
        return  AddProductView(viewModel: viewModel).environmentObject(flowData)
    }
}
