//
//  ProductDetailViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ProductDetailViewModel: ObservableObject {
    
    @Published var viewContent =
        ProductDetailViewContent(commentsStaticText: "Kommentek",
                                 productDetailHeader: ProductDetailHeaderRowViewContent(id: 0, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: "", producetNameStaticText: "termék:", productName: "", descriptonStaticText: "leírás:", description: "", imageUrl: nil, ratingStars: [0.0,0.0,0.0,0.0,0.0]),
                                 comments: [])
    
    private var ratings = [Rating]()
    
    var productId: Int
    private var productDetailModel: ProductDetailModel
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(productId: Int, productDetailModel: ProductDetailModel ){
        self.productId = productId
        self.productDetailModel = productDetailModel
        
    }
    
    func start() {
        productDetailModel.load()
            .map { self.createViewContent(product: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
            print(result)
        }) { content in
            self.viewContent = content
        }
        .store(in: &subscriptions)
    }
    
    private func createViewContent(product: ProductDetail) -> ProductDetailViewContent {
        
        let comments = product.ratings.map { (rating) -> ProductDetailCommentRowViewContent in
            ProductDetailCommentRowViewContent(starPercent: self.calculateStarCount(from: rating.rating), commenterName: rating.userName, commentTitle: rating.title, commentText: rating.text, commenterId: rating.userId)
        }
        
        let header = ProductDetailHeaderRowViewContent(id: product.id, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: product.producer, producetNameStaticText: "termék:", productName: product.name, descriptonStaticText: "leírás:", description: product.description, imageUrl: product.imageUrl, ratingStars: calculateStarPercents(from: product.average))
                
        return ProductDetailViewContent(commentsStaticText: "Kommentek:", productDetailHeader: header,comments: comments )
    }
        
    private func calculateStarPercents(from rating: Double) -> [Double] {
        var finish: Bool = false
        return (1...5).map{ i in
            if finish == true {
                return 0.0
            }
            if( Double(i) <= rating){
                return 1.0
            }else {
                let modulo = Double(rating.truncatingRemainder(dividingBy: 1.0))
                finish = true
                return modulo < 0 ? 0.0 : modulo
            }
        }
    }
    
    private func calculateStarCount(from rating: Int) -> [Double] {
        return (1...5).map { ($0<=rating) ? 1.0 : 0.0 }
    }
    
}
