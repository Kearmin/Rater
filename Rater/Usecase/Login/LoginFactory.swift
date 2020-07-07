//
//  LoginFactory.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 07. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI

class LoginFactory {
    
    static func createLoginView() -> some View {
        
        let model = LoginModel()
        let viewModel = LoginViewModel(model: model)
        let view = LoginView(viewModel: viewModel)
        
        return view
    }
}
