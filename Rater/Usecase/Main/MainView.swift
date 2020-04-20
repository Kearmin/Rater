//
//  MainView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 14..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ProductListFactory.createProductList()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }
                .tag(0)
            
            Text("Profile")
                .tabItem({
                    Image(systemName: "person")
                })
                .tag(1  )
            
            osaid()
                .environmentObject(ScannerFlowData())
                .tabItem({
                    Text("Hello")
                })
                .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewLayout(.sizeThatFits)
    }
}
