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
    @ObservedObject var keyboard = KeyboardResponder()
    
    @State var showCaptureImageView: Bool = false
    @State var image: UIImage? = nil
    
    @EnvironmentObject var data: ScannerFlowData
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 0.0) {
                            Image(uiImage: self.$viewModel.productImage.wrappedValue ?? UIImage(named: "noImage")!)
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
                                    .lineLimit(nil)
                                HStack {
                                    TextField("Barcode", text: $data.barcode)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    NavigationLink(destination: ScannerView(viewModel: ScannerViewModel())) {
                                        Image(systemName: "camera")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .background(Color.white)
                                            .frame(width: 40.0, height: 40.0)
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        Button(action: {
                            self.viewModel.createNewItem(barcode: self.data.barcode)
                        }) {
                            Text("Create Item")
                                .foregroundColor(Color.white)
                                .font(.title)
                        }
                        .frame(width: 380.0, height: 80.0, alignment: .center)
                        .background(Color.black)
                    }
                }
                .blur(radius: self.viewModel.isLoading ? 10.0 : 0.0)
                .offset(x: 0.0, y: -keyboard.currentHeight)
                if showCaptureImageView {
                    TakePictureView(isShown: $showCaptureImageView, image: self.$viewModel.productImage)
                }
                
                if self.viewModel.isLoading {
                    ActivityIndicator(isAnimating: self.$viewModel.isLoading, style: .large)
                        .zIndex(2.0)
                }
            }
            .alert(isPresented: self.$viewModel.isError) { () -> Alert in
                Alert(title: Text(""), message: Text(self.viewModel.errorMessage), dismissButton: .default(Text("Okay"), action: {
                    UIApplication.shared.endEditing()
                }))
            }
            .navigationBarTitle("Add New Item", displayMode: .inline)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(viewModel: AddProductViewModel(model: AddProductModel(), flowData: ScannerFlowData()))
    }
}
