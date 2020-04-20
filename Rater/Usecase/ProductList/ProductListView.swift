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
                            .frame(width: 50.0, height: 50.0, alignment: .center)
                            .cornerRadius(5.0)
                            .overlay(RoundedRectangle(cornerRadius: 5.0).stroke(Color.white,lineWidth: 4.0))
                            .shadow(color: Color.black.opacity(0.1),radius: 2.0)
                        
                    })
                    if isSearching {
                        Spacer()
                    }
                    TextField("Keresés", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: self.isSearching ? 280 : 0.0)
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
            .onAppear( perform: {self.viewModel.load()} )
            .padding(.top, 15.0)
            .navigationBarTitle(Text("Keresés"),displayMode: .inline)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(model: ProductListModel()))
    }
}
