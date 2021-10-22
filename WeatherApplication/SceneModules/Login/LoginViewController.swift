//
//  LoginViewController.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import UIKit

class LoginViewController:
    BaseViewController<LoginViewModel> {

    private var authenticationView: LoginAuthenticationView!
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        subscribeViewModelListeners()
        addAuthenticationView()
    }
    
    private func addAuthenticationView() {
        authenticationView = LoginAuthenticationView(data: viewModel.getLoginViewData())
        authenticationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(authenticationView)
        
        NSLayoutConstraint.activate([
        
            authenticationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authenticationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authenticationView.topAnchor.constraint(equalTo: view.topAnchor),
            
        ])
    }
    
    private func subscribeViewModelListeners()  {
        viewModel.listenLoginAction { [weak self] value in
            if value {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
