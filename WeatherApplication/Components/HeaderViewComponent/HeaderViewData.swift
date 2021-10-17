//
//  HeaderViewData.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 17.10.2021.
//

import Foundation

class HeaderViewData {
    
    private(set) var labelPackData: LabelPackComponentData
    private(set) var actionButtonData: ActionButtonData
    
    init(labelPackData: LabelPackComponentData,
         actionButtonData: ActionButtonData) {
        self.labelPackData = labelPackData
        self.actionButtonData = actionButtonData
    }
    
}
