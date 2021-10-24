//
//  LoginViewBuilder.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import UIKit

class LoginViewBuilder {
    
    class func build() -> UIViewController {
        let authenticationManager = AuthenticationManager.shared
        let formatter = LoginViewFormatter()
        let viewModel = LoginViewModel(authenticationManager: authenticationManager, formatter: formatter)
        return LoginViewController(viewModel: viewModel)
    }
    
}
