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
                                 productDetailHeader: ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: "", producetNameStaticText: "termék:", productName: "", descriptonStaticText: "leírás:", description: "", image: Image("E"), ratingStars: [0.0,0.0,0.0,0.0,0.0]),
            comments: [])
    private var productId: Int
    private var productDetailModel: ProductDetailModel
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(productId: Int, productDetailModel: ProductDetailModel ){
        self.productId = productId
        self.productDetailModel = productDetailModel
    }
    
    func start() {
        let ratingsPublisher = self.productDetailModel.getRatings()
        let averagePublisher = self.productDetailModel.getAverage()
        let productPublisher = self.productDetailModel.getProduct()
        
        _ = ratingsPublisher
            .print("PRODUCTDETAILVIEWMODEL::GETRATINGS()")
            //.zip(productPublisher, averagePublisher)
            .combineLatest(productPublisher, averagePublisher)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .map({ (ratings, product, average) in
                self.createViewContent(product: product, ratings: ratings, average: average)
            })
            .sink(receiveCompletion: { (error) in
                print("Received completion \(error)")
            }, receiveValue: { (content) in
                self.viewContent = content
                //self.objectWillChange.send()
            })
            .store(in: &subscriptions)
    }
    
    private func createViewContent(product: Product?, ratings: [Rating], average: Double) -> ProductDetailViewContent {
        
        let comments = ratings.map { (rating) -> ProductDetailCommentRowViewContent in
            ProductDetailCommentRowViewContent(starPercent: self.calculateStarCount(from: rating.rating), commenterName: "TEMP", commentTitle: rating.title, commentText: rating.text)
        }
        
        let header = ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: product?.producer ?? "", producetNameStaticText: "termék:", productName: product?.name ?? "", descriptonStaticText: "leírás:", description: product?.description ?? "", image: Image("E"), ratingStars: calculateStarPercents(from: average))
        
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
