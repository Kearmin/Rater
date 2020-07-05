//
//  ProductListRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 08..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListRowViewContent: Identifiable {
    let id: Int
    let imageUrl: URL?
    let name: String
}

struct ProductListRow: View {
    
    var content: ProductListRowViewContent
    
    var body: some View {
        HStack(alignment: .top) {
            WebImage(url: content.imageUrl)
                .resizable()
                .placeholder(Image("noImage"))
                .frame(width: 100.0, height: 100.0, alignment: .leading)
            VStack(alignment: .leading){
                Text(content.name)
                .bold()
                .font(.headline)
                .lineLimit(nil)
                .padding()
            }
            Spacer()
        }
    }
}

struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(content: ProductListRowViewContent(id: 0, imageUrl: nil, name: "hello")).previewLayout(.fixed(width: 300.0, height: 120.0))
    }
}
