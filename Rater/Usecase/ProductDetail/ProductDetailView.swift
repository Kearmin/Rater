//
//  ProductDetailView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI
import Combine

struct ProductDetailViewContent {
    let commentsStaticText: String
    let productDetailHeader: ProductDetailHeaderRowViewContent
    let comments: [ProductDetailCommentRowViewContent]
}

struct ProductDetailView: View {
    
    @ObservedObject var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    
    var body: some View {
        List {
            ProductDetailHeaderRow(viewContent: self.viewModel.viewContent.productDetailHeader)
                .padding(.bottom, 20.0)
            
            VStack(alignment: .leading, spacing: 12.0){
                Text(self.viewModel.viewContent.commentsStaticText)
                    .bold()
                ForEach(self.viewModel.viewContent.comments) { comment in
                    ProductDetailCommentRow(viewContent: comment)
                        .padding(.bottom, 5.0)
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(productId: 2, productDetailModel: ProductDetailModel(productId: 2)))
//        ProductDetailView(viewContent: ProductDetailViewContent(commentsStaticText: "Kommentek:", productDetailHeader: ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: "valami cég", producetNameStaticText: "név:", productName: "valami név", descriptonStaticText: "leírás:", description: "Nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon husszú értékelés", image: Image("E")), comments: [
//            ProductDetailCommentRowViewContent(id: UUID().uuidString, starPercent: [1.0,1.0,0.0,0.0,0.0], commenterName: "Valaki", commentTitle: "Rossz", commentText: "Nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon husszú komment"),
//            ProductDetailCommentRowViewContent(id: UUID().uuidString, starPercent: [1.0,1.0,1.0,1.0,1.0], commenterName: "én", commentTitle: "Nagyon jó", commentText: "Nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon husszú komment"),
//            ProductDetailCommentRowViewContent(id: UUID().uuidString, starPercent: [1.0,1.0,1.0,1.0,0.0], commenterName: "kjashd", commentTitle: "volt már jobb is...", commentText: "Nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon nagyon husszú komment")
//        ]))
    }
}
