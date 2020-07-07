//
//  AddRatingView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct AddRatingView: View {
    
    @ObservedObject var viewModel: AddRatingViewModel
    
    var body: some View {
        VStack(spacing: 10.0) {
            HStack(spacing: 30.0) {
                Text("Rating:")
                RatingStar(percent: 1.0)
                    .onTapGesture {
                        self.viewModel.changeRatingTo(1) }
                RatingStar(percent: self.viewModel.currentRating > 1 ? 1.0 : 0.0)
                    .onTapGesture {
                        self.viewModel.changeRatingTo(2) }
                RatingStar(percent: self.viewModel.currentRating > 2 ? 1.0 : 0.0)
                    .onTapGesture {
                        self.viewModel.changeRatingTo(3) }
                RatingStar(percent: self.viewModel.currentRating > 3 ? 1.0 : 0.0)
                    .onTapGesture {
                        self.viewModel.changeRatingTo(4) }
                RatingStar(percent: self.viewModel.currentRating > 4 ? 1.0 : 0.0)
                    .onTapGesture {
                        self.viewModel.changeRatingTo(5) }
                Spacer()
            }
            Spacer()
                .frame(height: 10.0)
            TextField("Title", text: self.$viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextView(text: self.$viewModel.description)
                .frame(height: 120.0)
            Button(action: {
                self.viewModel.createRating()
            }) {
                Text("Add Rating")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .frame(width: 350.0, height: 60.0)
            .background(Color.black)
            .buttonStyle(PlainButtonStyle())
            Spacer()
        }
        .alert(isPresented: self.$viewModel.isError) { () -> Alert in
            Alert(title: Text(""), message: Text(self.viewModel.errorMessage), dismissButton: .default(Text("Okay"), action: {
                UIApplication.shared.endEditing()
            }))
        }
        .navigationBarTitle(Text("Add rating"),displayMode: .inline)
        .padding()
    }
}

struct AddRatingView_Previews: PreviewProvider {
    static var previews: some View {
        AddRatingView(viewModel: AddRatingViewModel(model: AddRatingModel(), productId: 0))
    }
}
