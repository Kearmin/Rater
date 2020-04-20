//
//  osaid.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 26..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct osaid: View {
    
    @EnvironmentObject var data: ScannerFlowData
    
    var body: some View {
        NavigationView{
            
            
            
            List {
                Text(self.data.barcode ?? "")
                    .background(Color.red)
                
                NavigationLink(destination: ScannerView(viewModel: ScannerViewModel())) {
                    Text("Hello menjünk tovább")
                }
            }
        }
    }
}

struct osaid_Previews: PreviewProvider {
    static var previews: some View {
        osaid()
    }
}
