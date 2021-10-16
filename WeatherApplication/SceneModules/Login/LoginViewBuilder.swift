//
//  LoginViewBuilder.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import UIKit

class LoginViewBuilder {
    
    class func build() -> UIViewController {
        return LoginViewController(viewModel: LoginViewModel())
    }
    
}
