//
//  LoginAuthenticationViewData.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 19.10.2021.
//

import Foundation

class LoginAuthenticationViewData {
    
    private(set) var actionButtonData: ActionButtonData
    private(set) var signOutButton: ActionButtonData
    private(set) var emailLoginViewData: EmailLoginViewData
    
    init(actionButtonData: ActionButtonData,
         signOutButton: ActionButtonData,
         emailLoginViewData: EmailLoginViewData) {
        self.actionButtonData = actionButtonData
        self.signOutButton = signOutButton
        self.emailLoginViewData = emailLoginViewData
    }
    
}
