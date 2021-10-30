//
//  ItemTableViewCellData.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import Foundation
import UIKit

class ItemTableViewCellData: GenericDataProtocol {
    
    var type: GenericRowType? {
        return cellAction
    }
    
    private(set) var cellInfo: LabelPackComponentData
    private(set) var iconImage: UIImage
    private let cellAction: GenericRowType
    
    init(cellInfo: LabelPackComponentData,
         iconImage: UIImage,
         cellAction: GenericRowType) {
        self.cellInfo = cellInfo
        self.iconImage = iconImage
        self.cellAction = cellAction
    }
    
}
