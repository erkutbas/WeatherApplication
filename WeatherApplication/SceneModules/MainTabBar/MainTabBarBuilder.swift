//
//  MainTabBarBuilder.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

class MainTabBarBuilder {
    
    class func build() -> UIViewController {
        
        //let mainViewController = MainViewBuilder.build()

        let mainViewController = HomeWireframe().viewController
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.smooth.value
        mainViewController.navigationController?.navigationBar.standardAppearance = appearance;
        mainViewController.navigationController?.navigationBar.scrollEdgeAppearance = mainViewController.navigationController?.navigationBar.standardAppearance
        
        let AccountViewController = AccountViewBuilder.build()

        let tabViewController = MainTabBarController()
        tabViewController.viewControllers = [navigationController, AccountViewController]
        tabViewController.tabBar.tintColor = .black
        tabViewController.tabBar.backgroundColor = .systemBackground
        
        return tabViewController
        
    }
    
}
