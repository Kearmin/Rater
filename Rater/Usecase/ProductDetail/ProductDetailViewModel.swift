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
                                 productDetailHeader: ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: "", producetNameStaticText: "termék:", productName: "", descriptonStaticText: "leírás:", description: "", imageUrl: URL(string: "https://res.cloudinary.com/dk3njwejr/image/upload/v1593952619/h0guutudaeiehewiv2mb.jpg")!, ratingStars: [0.0,0.0,0.0,0.0,0.0]),
                                 comments: [])
    
    @Published var commenterIds = [Int]()
    
    private var ratings = [Rating]()
    
    var productId: Int
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
        
        //        _ = productPublisher
        //            .print("PRODUCTDETAILVIEWMODEL::USERNAME")
        //            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
        //            .compactMap {
        //                $0?.uploaderId
        //            }
        //            .map{
        //                self.productDetailModel.getName(id: $0)
        //            }
        //            .switchToLatest()
        //        .sink(receiveCompletion: { completion in
        //            print(completion)
        //        }, receiveValue: { name in
        //            print(name)
        //        })
        
        _ = ratingsPublisher
            .print("PRODUCTDETAILVIEWMODEL::GETRATINGS()")
            //.zip(productPublisher, averagePublisher)
            .combineLatest(productPublisher, averagePublisher)
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .map({ (ratings, product, average) in
                self.createViewContent(product: product,ratings: ratings, average: average)
            })
            .sink(receiveCompletion: { (error) in
                print("Received completion \(error)")
            }, receiveValue: { (content) in
                self.viewContent = content
            })
            .store(in: &subscriptions)
        
        _ = $commenterIds
            .dropFirst()
            .setFailureType(to: Error.self)
            .map{
                return $0
            }
            .map {
                self.namesPublisher(ids: $0)
            }
            .switchToLatest()
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { names in
                self.viewContent = self.updateViewContent(viewContent: self.viewContent, names: names)
            })
            .store(in: &subscriptions)
    }
    
    private func namesPublisher(ids: [Int]) -> AnyPublisher<[String], Error> {
        
        if ids.count > 0 {
            let first = self.productDetailModel.getName(id: ids[0])
            let remainder = Array(ids.dropFirst())
            
            return remainder.reduce(first) { combined, id -> AnyPublisher<String, Error> in
                return combined
                    .merge(with: self.productDetailModel.getName(id: id))
                    .eraseToAnyPublisher()
                }
                .collect(ids.count)
                .eraseToAnyPublisher()
        }
        
        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    private func createViewContent(product: Product?, ratings: [Rating], average: Double) -> ProductDetailViewContent {
        
        let comments = ratings.map { (rating) -> ProductDetailCommentRowViewContent in
            ProductDetailCommentRowViewContent(starPercent: self.calculateStarCount(from: rating.rating), commenterName: "TEMP", commentTitle: rating.title, commentText: rating.text)
        }
        
        let header = ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: product?.producer ?? "", producetNameStaticText: "termék:", productName: product?.name ?? "", descriptonStaticText: "leírás:", description: product?.description ?? "", imageUrl: product?.imageUrl, ratingStars: calculateStarPercents(from: average))
        
        
        self.commenterIds = ratings.map {  $0.uploaderId }
        
        return ProductDetailViewContent(commentsStaticText: "Kommentek:", productDetailHeader: header,comments: comments )
    }
    
    private func updateViewContent(viewContent: ProductDetailViewContent, names: [String]) -> ProductDetailViewContent {
        
        let newComments = zip(viewContent.comments, names).map { (comment, name) -> ProductDetailCommentRowViewContent in
            ProductDetailCommentRowViewContent(starPercent: comment.starPercent, commenterName: name, commentTitle: comment.commentTitle, commentText: comment.commentText)
        }
        
        return ProductDetailViewContent(commentsStaticText: "Kommentek:", productDetailHeader: viewContent.productDetailHeader,comments: newComments)
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
