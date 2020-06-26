//
//  AddProductView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 06. 24..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var viewModel: AddProductViewModel
    @State var showCaptureImageView: Bool = false
    @State var image: Image? = nil
    @EnvironmentObject var data: ScannerFlowData
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                Text("Add new item")
                    .font(.largeTitle)
                    .padding([.top,.leading])
                
                VStack(alignment: .leading, spacing: 0.0) {
                    (self.image ?? Image("E"))
                        .resizable()
                        .frame(width: 110.0, height: 110.0, alignment: .center)
                        .padding()
                        .padding(.leading, 110.0)
                        .onTapGesture {
                            self.showCaptureImageView.toggle()
                    }
                    Group {
                        TextField("Name", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Producer", text: $viewModel.producer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Description", text: $viewModel.description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Barcode", text: $viewModel.barcode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                }
                Spacer()
                
                Button(action: {
                    //self.viewModel.createNewItem()
                }) {
                    Text("Create Item")
                        .foregroundColor(Color.white)
                        .font(.title)
                }
                .frame(width: 380.0, height: 80.0, alignment: .center)
                .background(Color.black)
            }
            if showCaptureImageView {
                TakePictureView(isShown: $showCaptureImageView, image: $image)
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(viewModel: AddProductViewModel(model: AddProductModel()))
    }
}
