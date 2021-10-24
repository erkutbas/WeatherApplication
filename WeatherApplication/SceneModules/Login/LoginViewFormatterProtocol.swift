//
//  LoginViewFormatterProtocol.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 24.10.2021.
//

import Foundation

protocol LoginViewFormatterProtocol {
    
    func getLoginViewData(
        loginActionButtonCompletion: @escaping VoidCompletionBlock,
        emailChangeCompletion: @escaping SugarTextChangeBlock,
        passwordChangeCompletion: @escaping SugarTextChangeBlock) -> LoginAuthenticationViewData
    
}
