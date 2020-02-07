//
//  ContentView.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import CodableFirebase
import Combine

struct ContentView: View {
    
    @ObservedObject var test: test
    
    var body: some View {
        Text(test.string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(test: test())
    }
}
