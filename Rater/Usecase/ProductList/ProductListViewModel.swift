//
//  ProductListViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Cloudinary

class ProductListViewModel: ObservableObject {
    
    @Published var viewContent: ProductListViewContent = ProductListViewContent(rows: [])
    
    @Published var searchText: String = ""
    
    private var usecasePublisher = CurrentValueSubject<[Product],Error>([])
    private var scannerData: ScannerFlowData
    
    var model: ProductListModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: ProductListModel, scannerData: ScannerFlowData) {
        self.model = model
        self.scannerData = scannerData
        self.setupText()
        self.setupContentGenerator()
        self.load()
    }

    private func setupText(){
        
        self.scannerData.$barcode
            .sink { barcode in
                self.searchText = barcode
            }
            .store(in: &subscriptions)
        
        $searchText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink(receiveCompletion: { (error) in
                print(error)
            }, receiveValue: { (string) in
                self.usecasePublisher.send(self.usecasePublisher.value)
            })
            .store(in: &subscriptions)
    }
    
    private func setupContentGenerator(){
        
        self.usecasePublisher
            .map { products in
                products.filter { (product) -> Bool in
                    
                    if self.searchText != "" {
                        if product.name.lowercased().contains(self.searchText.lowercased()) {
                            return true
                        }
                        if "\(product.barcode)".contains(self.searchText) {
                            return true
                        }
                        return false
                    } else {
                        return true
                    }
                }
            }
            .map { (products) in
                self.createViewContent(from: products)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (content) in
                self.viewContent = content
            }
            .store(in: &subscriptions)
        
    }
    
    func load(){
        
        self.model.getAllProducts()
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (products) in
                guard products.isEmpty == false else { return }
                self.usecasePublisher.value = self.usecasePublisher.value + products
            }
            .store(in: &subscriptions)
    }
    
    private func createViewContent(from products: [Product]) -> ProductListViewContent {
        
        var viewContent = ProductListViewContent(rows: [])
        
        _ = products.map({ product in
            viewContent.rows.append(ProductListRowViewContent(id: product.id, imageUrl: product.imageUrl, name: product.name, isLast: product.id == products.last!.id))
        })
        
        return viewContent
    }
}
