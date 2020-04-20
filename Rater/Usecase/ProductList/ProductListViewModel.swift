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

class ProductListViewModel: ObservableObject {
    
    @Published var viewContent: ProductListViewContent = ProductListViewContent(rows: [])
    
    @Published var searchText: String = ""
    
    private var usecasePublisher = CurrentValueSubject<[Product],Error>([])
    
    var model: ProductListModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: ProductListModel) {
        self.model = model
        self.setupText()
        self.setupContentGenerator()
    }

    private func setupText(){
        
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
                    self.searchText != "" ?
                        product.name
                            .lowercased()
                            .contains(self.searchText.lowercased()) : true
                }
            }
            .map { (products) in
                self.createViewContent(from: products)
            }
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (content) in
                self.viewContent = content
                print(content)
            }
            .store(in: &subscriptions)
        
    }
    
    func load(){
        
        self.model.getAllProducts()
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (products) in
                self.usecasePublisher.value = products
            }
            .store(in: &subscriptions)
        
        
//        self.model.getAllProducts()
//            .map { (products) in
//                self.createViewContent(from: products)
//            }
//            .sink(receiveCompletion: { (error) in
//                print(error)
//            }) { (content) in
//                self.viewContent = content
//                print(content)
//            }
//            .store(in: &subscriptions)
    }
    
    private func createViewContent(from products: [Product]) -> ProductListViewContent {
        
        var viewContent = ProductListViewContent(rows: [])
        
        _ = products.map({ product in
            viewContent.rows.append(ProductListRowViewContent(id: product.id, image: Image("E"), name: product.name))
        })
        
        return viewContent
    }
}
