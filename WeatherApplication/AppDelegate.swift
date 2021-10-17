//
//  AppDelegate.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        self.window = UIWindow()
        let mainView = SplashViewBuilder.build {
            print("splash finalize")
            self.initializeMainView()
        }
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()
        
        return true
    }

    private func initializeMainView() {
        DispatchQueue.main.async {
            UIView.transition(with: self.window!, duration: 0.3, options: .transitionCrossDissolve) {
                self.fireMainView()
            }
        }
    }
    
    private func fireMainView() {
        let mainView = MainTabBarBuilder.build()
        
        window?.rootViewController = mainView
        window?.makeKeyAndVisible()
    }

}

