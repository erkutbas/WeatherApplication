//
//  TextFieldViewData.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 19.10.2021.
//

import Foundation

typealias SugarTextChangeBlock = (String?) -> Void

class TextFieldViewData {
    
    private(set) var placeHolder: String
    private(set) var isSecureTextEntry: Bool
    private(set) var sugarTextChangeListener: SugarTextChangeBlock?
    
    init(placeHolder: String, isSecureTextEntry: Bool = false) {
        self.placeHolder = placeHolder
        self.isSecureTextEntry = isSecureTextEntry
    }
    
    func setSugarTextChangeListener(by value: @escaping SugarTextChangeBlock) -> Self {
        sugarTextChangeListener = value
        return self
    }
    
    
}
