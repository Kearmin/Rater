//
//  ScannerViewModel.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 26..
//  Copyright © 2020. Jenci. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class ScannerViewModel: ObservableObject {
    
    @Published var shouldFinish = false
    
    var finishPublisher = PassthroughSubject<String, Never>()
    
    init(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleBarcode(_:)), name: NSNotification.Name( "FoundBarcode"), object: nil)
    }
    
    @objc func handleBarcode(_ notification: Notification){
        print(notification.userInfo?["code"])
        self.finishPublisher.send(notification.userInfo!["code"]! as! String)
    }
    
}
