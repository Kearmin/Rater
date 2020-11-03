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
    
    
    private var currentSource: AnyCancellable?
    
    var model: ProductListModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(model: ProductListModel, scannerData: ScannerFlowData) {
        self.model = model
        self.scannerData = scannerData
        self.setupText()
        self.setupContentGenerator()
        self.setupNotification()
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
                UIApplication.shared.endEditing()
                self.usecasePublisher.send([])
                self.load(with: string, refresh: true)
            })
            .store(in: &subscriptions)
    }
    
    private func setupContentGenerator(){
        
        self.usecasePublisher
            .map { array -> [Product] in
                let set = Set(array)
                return Array(set)
            }
            .map {
                var mutable = $0
                mutable.sort { p1, p2 in
                    p1.id > p2.id
                }
                return mutable
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
    
    private func setupNotification() {
        NotificationCenter.default.publisher(for: .init("SavedNew"))
            .sink { (_) in
                self.load(with: nil, refresh: true)
            }
            .store(in: &subscriptions)
    }
    
    func load(with text: String? = nil, refresh: Bool = false){
                
        if refresh {
            model.afterId = nil
            model.shouldLoad = true
        }
        
        guard model.shouldLoad == true else { return }
        
        if let source = currentSource {
            source.cancel()
            currentSource = nil
        }
        
        self.currentSource = self.model.getAllProducts(searchString: text)
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (products) in
                self.usecasePublisher.value = self.usecasePublisher.value + products
            }
        
        self.currentSource?.store(in: &subscriptions)
        
    }
    
    private func createViewContent(from products: [Product]) -> ProductListViewContent {
        
        let content = products.map({ product in
         ProductListRowViewContent(id: product.id, imageUrl: product.imageUrl, name: product.name, isLast: product.id == products.last!.id)
        })
        
        return .init(rows: content)
    }
}
