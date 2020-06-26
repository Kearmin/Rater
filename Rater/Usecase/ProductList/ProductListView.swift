//
//  ProductListView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductListViewContent : Identifiable{
    let id: String = UUID().uuidString
    var rows: [ProductListRowViewContent]
}

struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductListViewModel
    
    
    init(viewModel: ProductListViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Keresés", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading,.trailing,.top], 10.0)
                
                List (self.viewModel.viewContent.rows) { row in
                    NavigationLink(destination:
                        ProductDetailFactory.createProductDetail(with: row.id)
                    ) {
                        ProductListRow(content: row)
                            .frame(width: nil, height: 120.0)
                    }
                }
                .onAppear( perform: {self.viewModel.load()} )
                .navigationBarTitle(Text("Keresés"),displayMode: .inline)
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(model: ProductListModel()))
    }
}
