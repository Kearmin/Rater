//
//  ProductListView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 10..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct ProductListViewContent{
    var rows: [ProductListRowViewContent]
}

struct ProductListView: View {
    
    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var data: ScannerFlowData
    
    init(viewModel: ProductListViewModel) {
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Keresés", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.leading,.trailing,.top], 10.0)
                        .disableAutocorrection(true)
                    NavigationLink(destination: ScannerView(viewModel: ScannerViewModel())) {
                        Image(systemName: "camera")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(Color.white)
                            .frame(width: 30.0, height: 30.0)
                            .padding([.trailing])
                            .padding([.top], 7.0)
                    }
                }
                
                List (self.viewModel.viewContent.rows) { row in
                    NavigationLink(destination:
                        ProductDetailFactory.createProductDetail(with: row.id)
                    ) {
                        ProductListRow(content: row)
                            .onAppear {
                                if row.isLast {
                                    self.viewModel.load()
                                }
                        }
                    }
                }
                .navigationBarTitle(Text("Keresés"),displayMode: .inline)
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(model: ProductListModel(), scannerData: ScannerFlowData()))
    }
}
