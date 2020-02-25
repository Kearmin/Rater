//
//  ProductListRow.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 08..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductListRowViewContent: Identifiable {
    let id: Int
    let image: Image
    let name: String
}

struct ProductListRow: View {
    
    var content: ProductListRowViewContent
    
    var body: some View {
        HStack {
            Image("E")
                .resizable()
                .frame(width: 100.0, height: 100.0, alignment: .leading)
            VStack{
                Text("nagyaon nagyin hosszú név lorem ipsum lorem ipsum")
                Text("lorem ipsum lorem ipsum ")
            }
            Spacer()
        }
    }
}

struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(content: ProductListRowViewContent(id: 0, image: Image("E"), name: "hello")).previewLayout(.fixed(width: 200.0, height: 100.0))
    }
}
