//
//  TextFieldView.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 19.10.2021.
//

import UIKit
import SwiftUI

class SugarTextFieldView: GenericBaseView<TextFieldViewData> {

    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var textField: UITextField = {
        let temp = UITextField()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clearButtonMode = .whileEditing
        //temp.delegate = self
        temp.addTarget(self, action: .catchTextFieldChanges, for: .editingChanged)
        return temp
    }()
    
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addUserInterfaceComponent()
    }
    
    private func addUserInterfaceComponent() {
        addSubview(containerView)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
        
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            
        ])
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        textField.placeholder = data.placeHolder
        textField.isSecureTextEntry = data.isSecureTextEntry
    }
    
    @objc func catchTextFieldChanges(_ sender: UITextField) {
        returnData()?.sugarTextChangeListener?(sender.text)
    }
    
}

extension SugarTextFieldView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        returnData()?.sugarTextChangeListener?(textField.text)
    }
    
}

fileprivate extension Selector {
    
    static let catchTextFieldChanges = #selector(SugarTextFieldView.catchTextFieldChanges)
}
