//
//  CharacterItemCollectionViewCell.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 30.10.2021.
//

import UIKit

class CharacterItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterItemImage: UIImageView!
    @IBOutlet weak var characterLabelName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureProperties()
    }
    
    func configureProperties() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 6
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
    }
}
