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
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }
    
    func getLoginViewData() -> LoginAuthenticationViewData {
        return LoginAuthenticationViewData(actionButtonData: ActionButtonData(text: "Login", buttonType: .filled(.sugarLevelColor)).setActionButtonListener(by: loginActionButtonListener),signOutButton: ActionButtonData(text: "Sign out", buttonType: .filled(.bright)).setActionButtonListener(by: signOutActionButtonListener), emailLoginViewData: EmailLoginViewData(email: TextFieldViewData(placeHolder: "Email"), password: TextFieldViewData(placeHolder: "Password")))
    }
    
    func listenLoginAction(with completion: @escaping BooleanBlock) {
        loginViewBlock = completion
    }
    
    // MARK: - Private Methods
    private func fireSignIn() {
        authenticationManager.signIn(with: SimpleAuthenticationRequest(email: "takasi@gmail.com", password: "123456"))
        loginViewBlock?(true)
    }
    
    private func fireSignOut() {
        authenticationManager.logout()
    }
    
    private lazy var loginActionButtonListener: VoidBlock = { [weak self] in
        print("button tapped")
        self?.fireSignIn()
    }
    
    private lazy var signOutActionButtonListener: VoidBlock = { [weak self] in
        self?.fireSignOut()
    }
    
}
