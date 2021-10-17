//
//  HeaderView.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 17.10.2021.
//

import UIKit

class HeaderView: GenericBaseView<HeaderViewData> {
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .white
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 4
        temp.layer.shadowOpacity = 0.2
        temp.layer.cornerRadius = 8
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [headerInfo, loginButton])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .fill
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 20
        return temp
    }()
    
    private lazy var headerInfo: LabelPackComponent = {
        let temp = LabelPackComponent(data: getLabelPackComponentData())
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var loginButton: ActionButton = {
        let temp = ActionButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: 50).isActive = true
        temp.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        return temp
    }()
    
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addContainers()
    }
    
    private func addContainers() {
        addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
        
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            mainStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 20),
            
        ])
    }
    
    private func getLabelPackComponentData() -> LabelPackComponentData {
        return LabelPackComponentData()
            .setSubTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .left).setTextAlignment(by: .left).setNumberOfLines(by: 2).setLineBreakMode(by: .byTruncatingTail).setFont(by: MainFont.regular(16).value))
            .setTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .left).setTextAlignment(by: .left).setNumberOfLines(by: 1).setLineBreakMode(by: .byTruncatingTail).setFont(by: MainFont.bold(24).value))
            .setSpacing(by: 10)
            .setStackViewAlignment(by: .fill)
        
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        headerInfo.setData(by: data.labelPackData)
        loginButton.setData(by: data.actionButtonData)
    }
    
}
