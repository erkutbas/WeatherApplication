//
//  AuthenticationManager.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import Foundation
import FirebaseAuth

class AuthenticationManager: AuthenticationManagerProtocol {
    
    public static let shared = AuthenticationManager()
    
    private init() { }
    
    func isLoggedIn(with completion: @escaping BooleanBlock) {
        Auth.auth().addStateDidChangeListener { auth, user in
            completion((user != nil) ? true : false)
        }
    }

    func signIn(with request: SimpleAuthenticationRequest) {

    }
    
    func logout() {
        
    }
    
    func register()  {
        
    }
    
    func xxx()  {
        
    }
    
}
