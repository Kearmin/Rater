//
//  ScannerView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 26..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

class ScannerFlowData: ObservableObject {
    @Published var didFinishScanning: Bool = false
    @Published var barcode: String = ""
}

struct ScannerViewControllerReplesentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ScannerViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerViewControllerReplesentable>) -> ScannerViewController {
        
        let scanner = ScannerViewController()
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: UIViewControllerRepresentableContext<ScannerViewControllerReplesentable>) {
    }
}

struct ScannerView: View {
    
    @ObservedObject var viewModel: ScannerViewModel
    @EnvironmentObject var flowData: ScannerFlowData
    @Environment(\.presentationMode) var presentation
    
    init(viewModel: ScannerViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack{
                ScannerViewControllerReplesentable()
            }
            .onReceive(self.viewModel.finishPublisher) { string in
                print(string)
                self.flowData.didFinishScanning = true
                self.flowData.barcode = string
                self.presentation.wrappedValue.dismiss()
            }
            .navigationBarTitle("Scan Barcode", displayMode: .inline)
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(viewModel: ScannerViewModel())
            .environmentObject(ScannerFlowData())
    }
}
