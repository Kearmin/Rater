//
//  LoginView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        
        VStack(spacing: 10.0) {
            
            if self.viewModel.loggedInUser != nil {
                Text("Logged in as: ")
                    .font(.title)
                Text(self.viewModel.loggedInUser!)
                    .bold()
                    .font(.title)
                Spacer()
                    .frame(height: 10.0)
                Button(action: {
                    self.viewModel.logOut()
                }) {
                    Text("Logout")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(width: 300.0)
                .buttonStyle(PlainButtonStyle())
                .background(Color.black)

                
            } else {
                
                TextField("Username", text: self.$viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: self.$viewModel.password)
                    
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Group {
                    Button(action: {
                        self.viewModel.login()
                    }) {
                        Text("Login")
                            .font(.title)
                    }
                    Button(action: {
                        self.viewModel.signUp()
                    }) {
                        Text("Sign Up")
                            .font(.title)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .alert(isPresented: self.$viewModel.isError) { () -> Alert in
            Alert(title: Text(""), message: Text(self.viewModel.errorMessage), dismissButton: .default(Text("Okay"), action: {
                UIApplication.shared.endEditing()
            }))
        }
        .padding()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(model: LoginModel()))
    }
}
