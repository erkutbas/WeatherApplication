//
//  MainViewModel.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import Foundation

class MainViewModel {
    
    private var loginStateListener: BooleanBlock?
    
    private let authenticationManager: AuthenticationManagerProtocol
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
        listenUserState()
    }
    
    private func listenUserState() {
        authenticationManager.isLoggedIn { [weak self] state in
            print("USER STATE : \(state)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.loginStateListener?(state)
            }
        }
    }
    
    func subscribeLoginState(with completion: @escaping BooleanBlock) {
        loginStateListener = completion
    }
    
}
