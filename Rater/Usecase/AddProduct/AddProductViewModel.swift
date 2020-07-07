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
            .sink(receiveCompletion: { Result in
                print(Result)
            }) { imageUrl in

                let product = Product(name: self.name, id: ObjectContainer.sharedInstace.refIds.productId + 1, uploaderId: user.id, producer: self.producer, description: self.description, imageUrl: imageUrl, category: .undefined, price: nil, barcode: Int(barcode))
                self.addProductModel.createProduct(product: product)
                ObjectContainer.sharedInstace.refIds.productId += 1
                
                self.name = ""
                self.producer = ""
                self.description = ""
                self.flowData.barcode = ""
                self.productImage = UIImage(named: "noImage")
                
                UIApplication.shared.endEditing()
                self.isLoading = false
            }
            .store(in: &subscriptions)
    }
    
    func takePicture() {
        print("take picture")
        
        let config = CLDConfiguration(cloudName: "CLOUD_NAME", secure: true)
        let cloudinary = CLDCloudinary(configuration: config)
        
        let request = cloudinary.createUploader().upload(
            url: URL(string: "")!, uploadPreset: "samplePreset") { (response, error) in
            // Handle response
                
            print(response)
            
        }

        
    }
    
    init(model: AddProductModel, flowData: ScannerFlowData) {
        self.addProductModel = model
        self.flowData = flowData
    }
}
