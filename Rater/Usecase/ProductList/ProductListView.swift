//
//  ProductListView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductListViewContent : Identifiable{
    let id: UUID = UUID()
    var rows: [ProductListRowViewContent]
}

struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductListViewModel
    
    @State private var isSearching: Bool = false
    
    init(viewModel: ProductListViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack{
                HStack(spacing: 0.0) {
                    if !isSearching {
                        Spacer()
                    }
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.isSearching.toggle()
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .frame(width: 30.0, height: 30.0, alignment: .center)
                            .background(Color.gray)
                            .cornerRadius(5.0)
                        
                    })
                    if isSearching {
                        Spacer()
                    }
                    TextField("Keresés", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: self.isSearching ? 300.0 : 0.0)
                        .fixedSize()
                }
                .padding([.leading, .trailing])
                
                List (self.viewModel.viewContent.rows) { row in
                    NavigationLink(destination:
                        ProductDetailFactory.createProductDetail(with: row.id)
                    ) {
                        ProductListRow(content: row)
                            .frame(width: nil, height: 120.0)
                    }
                    
                }
            }
            .navigationBarTitle(Text("Keresés"))
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(model: ProductListModel()))
    }
}
