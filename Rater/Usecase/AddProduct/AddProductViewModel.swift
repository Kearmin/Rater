//
//  AddProductViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import Cloudinary
import Combine
import SwiftUI

class AddProductViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var producer: String = ""
    @Published var description: String = ""
    @Published var productImage: UIImage? = UIImage(named: "noImage")
    @Published var isEditing: Bool = false
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    private var flowData: ScannerFlowData
    
    private let addProductModel: AddProductModel
    
    func createNewItem(barcode: String) {
        
        guard let image = productImage else { return }
        
        guard let user = ObjectContainer.sharedInstace.user else {
            self.isError = true
            self.errorMessage = "Please log in to post a new product"
            return
        }
        
        self.isLoading = true
        
        self.addProductModel.saveImage(image)
            .flatMap { imageUrl in
                self.addProductModel.createProduct(product: Product(name: self.name, id: -1, uploaderId: user.id, producer: self.producer, description: self.description, imageUrl: imageUrl, barcode: barcode))
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { result in
            print(result)
        }) { (product) in
            self.name = ""
            self.producer = ""
            self.description = ""
            self.flowData.barcode = ""
            self.productImage = UIImage(named: "noImage")
            
            UIApplication.shared.endEditing()
            self.isLoading = false
            self.errorMessage = "Success"
            self.isError = true
        }
        .store(in: &subscriptions)
    }
    
    init(model: AddProductModel, flowData: ScannerFlowData) {
        self.addProductModel = model
        self.flowData = flowData
    }
}
