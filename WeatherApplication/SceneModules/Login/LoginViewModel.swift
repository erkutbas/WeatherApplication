//
//  LoginViewModel.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import Foundation

class LoginViewModel {

    private var loginViewBlock: BooleanBlock?
    
    private let authenticationManager: AuthenticationManagerProtocol
    private let formatter: LoginViewFormatterProtocol
    private var email: String?
    private var password: String?

    init(authenticationManager: AuthenticationManagerProtocol,
         formatter: LoginViewFormatterProtocol) {
        self.authenticationManager = authenticationManager
        self.formatter = formatter
    }
    
    func getLoginViewData() -> LoginAuthenticationViewData {
        return formatter.getLoginViewData(loginActionButtonCompletion: loginActionButtonListener, emailChangeCompletion: emailChangeListener, passwordChangeCompletion: passwordChangeListener)
        
    }
    
    func listenLoginAction(with completion: @escaping BooleanBlock) {
        loginViewBlock = completion
    }
    
    // MARK: - Private Methods
    private func fireSignIn() {
        guard let email = email, let password = password else { return }
        authenticationManager.signIn(with: SimpleAuthenticationRequest(email: email, password: password))
        loginViewBlock?(true)
    }
    
    private func fireSignOut() {
        authenticationManager.logout()
    }
    
    private lazy var loginActionButtonListener: VoidBlock = { [weak self] in
        print("button tapped")
        self?.fireSignIn()
    }
    
    private lazy var emailChangeListener: SugarTextChangeBlock = { [weak self] text in
        print("email : \(text)")
        self?.email = text
    }
    
    private lazy var passwordChangeListener: SugarTextChangeBlock = { [weak self] text in
        print("password : \(text)")
        self?.password = text
    }
    
    private lazy var signOutActionButtonListener: VoidBlock = { [weak self] in
        self?.fireSignOut()
    }
    
}
