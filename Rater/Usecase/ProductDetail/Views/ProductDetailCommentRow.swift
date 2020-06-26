//
//  ProductDetailCommentRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 07..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductDetailCommentRowViewContent: Identifiable {
    let id: String = UUID().uuidString
    let starPercent: [Double]
    var commenterName: String
    let commentTitle: String
    let commentText: String
}

struct ProductDetailCommentRow: View {
    
    var viewContent: ProductDetailCommentRowViewContent
    
    @State private var showModal = false
    
    var selectedId: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0){
            HStack(spacing: 10.0){
                NavigationLink(destination: UserCommentFactory.createUserComment(id: self.selectedId ?? 0), label: {
                    Text(self.viewContent.commenterName)
                        .foregroundColor(.gray)
                        .fixedSize()
                        .frame(idealWidth: 20.0)
                })
                HStack(spacing: 2.0){
                    RatingStar(percent: self.viewContent.starPercent[0])
                    RatingStar(percent: self.viewContent.starPercent[1])
                    RatingStar(percent: self.viewContent.starPercent[2])
                    RatingStar(percent: self.viewContent.starPercent[3])
                    RatingStar(percent: self.viewContent.starPercent[4])
                }
            }
            VStack(alignment: .leading, spacing: 0.0){
                Text(viewContent.commentTitle)
                    .bold()
                    .padding(.bottom, 5.0)
                
                Text(viewContent.commentText)
            }
        }
        .sheet(isPresented: $showModal) {
            UserCommentFactory.createUserComment(id: self.selectedId ?? 0)
        }
    }
}

struct RatingStar: View {
    
    let kBorderPercent: Double = 1.001
    let kMaxWidth: Double = 20.0
    let percent: Double
    
    var body: some View{
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .overlay(Image(systemName: "star"))
            .frame(width: (CGFloat(self.kMaxWidth * percent)), height: 20.0, alignment: .leading)
            .clipShape(Rectangle())
    }
}

struct ProductDetailCommentRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailCommentRow(viewContent: ProductDetailCommentRowViewContent(starPercent: [1.0,1.0,1.0,1.0,0.44], commenterName: "Arminous", commentTitle: "Nagyon jó!!!", commentText: "Amióta ezt a terméket használom azt se tudom mi van velem, Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum"))
            .previewLayout(.fixed(width: 450, height: 150))
    }
}
