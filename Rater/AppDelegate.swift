//
//  AppDelegate.swift
//  Rater
//
//  Created by Kertész Jenő on 2020. 02. 05..
//  Copyright © 2020. Jenci. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import Combine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var subscriptions = Set<AnyCancellable>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        UserNamePublisher.userName(for: 2).subject
            .print()
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                print(completion)
            }) { name in
                print(name)
            }
            .store(in: &subscriptions)
        
//        FirebaseWriteOperations(databaseReference: Database.database().reference()).createProduct(product:
//            Product(name: "testststst", id: 4, uploaderId: 999, producer: "valaki", description: "ASGDHASGDK", imageUrl: nil, category: .cosmetics, price: nil))
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

