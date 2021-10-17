//
//  ItemTableViewCell.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

class ItemTableViewCell: BaseTableViewCell {
    
    private lazy var containerView: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [cellInfo, icon])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .center
        temp.distribution = .fill
        temp.axis = .horizontal
        temp.spacing = 20
        return temp
    }()
    
    private lazy var cellInfo: LabelPackComponent = {
        let temp = LabelPackComponent(data: getLabelPackComponentData())
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private lazy var icon: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.heightAnchor.constraint(equalToConstant: 24).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return temp
    }()
    
    override func addMajorViews() {
        super.addMajorViews()
        addUserComponents()
    }
    
    override func setupView() {
        super.setupView()
        selectionStyle = .none
    }
    
    private func addUserComponents() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
        ])
        
    }
    
    func setData(by value: GenericDataProtocol) {
        guard let data = value as? ItemTableViewCellData else { return }
        cellInfo.setData(by: data.cellInfo)
        icon.image = data.iconImage.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .black
    }
    
    private func getLabelPackComponentData() -> LabelPackComponentData {
        return LabelPackComponentData()
            .setSubTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .left).setTextAlignment(by: .left).setNumberOfLines(by: 2).setLineBreakMode(by: .byTruncatingTail))
            .setTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .left).setTextAlignment(by: .left).setNumberOfLines(by: 1).setLineBreakMode(by: .byTruncatingTail))
            .setSpacing(by: 5)
            .setStackViewAlignment(by: .fill)
        
    }
    
}
