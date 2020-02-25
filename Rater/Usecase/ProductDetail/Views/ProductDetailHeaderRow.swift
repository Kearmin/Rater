//
//  ProductDetailHeaderRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 08..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductDetailHeaderRowViewContent: Identifiable {
    let id: String
    let title: String
    let productMakerStaticText: String
    let productMaker: String
    let producetNameStaticText: String
    let productName: String
    let descriptonStaticText: String
    let description: String
    let image: Image
    let ratingStars: [Double]
}

struct ProductDetailHeaderRow: View {
    
    var viewContent: ProductDetailHeaderRowViewContent
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20.0){
            HStack(spacing: 30.0){
                Text(self.viewContent.title)
                    .font(.largeTitle)
                    .bold()
                HStack(spacing: 5.0){
                    RatingStar(percent: self.viewContent.ratingStars[0])
                    RatingStar(percent: self.viewContent.ratingStars[1])
                    RatingStar(percent: self.viewContent.ratingStars[2])
                    RatingStar(percent: self.viewContent.ratingStars[3])
                    RatingStar(percent: self.viewContent.ratingStars[4])
                }
            }

            HStack{
                self.viewContent.image
                    .resizable()
                    .frame(width: 150.0, height: 150.0, alignment: .center)
                    .cornerRadius(10.0)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.gray, lineWidth: 4.0))
                Spacer()
                VStack(alignment: .leading, spacing: 20.0){
                    VStack(alignment: .leading, spacing: 5.0){
                        Text(self.viewContent.productMakerStaticText)
                            .bold()
                            .font(.headline)
                        Text(self.viewContent.productMaker)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(alignment: .leading, spacing: 5.0){
                        Text(self.viewContent.producetNameStaticText)
                            .bold()
                            .font(.headline)
                        Text(self.viewContent.productName)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            VStack(alignment: .leading, spacing: 5.0){
                Text(self.viewContent.descriptonStaticText)
                    .bold()
                Text(self.viewContent.description)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
        .padding(.top, 5.0)
    }
}

struct ProductDetailHeaderRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailHeaderRow(viewContent: ProductDetailHeaderRowViewContent(id: UUID().uuidString, title: "Értékelés", productMakerStaticText: "gyártó:", productMaker: "H&M", producetNameStaticText: "termék:", productName: "Lord Farquaad", descriptonStaticText: "leírás:", description: "Leírás Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum ", image: Image("E"), ratingStars: [1.0,1.0,0.4,0.0,0.0]))
            .previewLayout(.fixed(width: 400.0, height: 400.0))
    }
}
