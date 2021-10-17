//
//  AccountViewDataFormatter.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 17.10.2021.
//

import UIKit

class AccountViewDataFormatter: AccountViewDataProtocol {
    
    func getAccountViewComponentData() -> [GenericDataProtocol] {
        
        let settings = LabelPackComponentData(title: "Settings")
            .setTitleLabelDistributionData(by: LabelDistributionData()
                                            .setFont(by: MainFont.regular(12).value)
                                            .setTextAlignment(by: .left)
                                            .setContentMode(by: .center)
                                            .setNumberOfLines(by: 1))
        
        let help = LabelPackComponentData(title: "Help")
            .setTitleLabelDistributionData(by: LabelDistributionData()
                                            .setFont(by: MainFont.regular(12).value)
                                            .setTextAlignment(by: .left)
                                            .setContentMode(by: .center)
                                            .setNumberOfLines(by: 1))
              
        return [ItemTableViewCellData(cellInfo: settings, iconImage: SFSymbolsHelper.gearshape.value!, cellAction: .settings),
                ItemTableViewCellData(cellInfo: help, iconImage: SFSymbolsHelper.questionmark.value!, cellAction: .settings)]
                                           
    }
    
    func getHeaderViewData(with completion: @escaping VoidCompletionBlock) -> HeaderViewData {
        
        return HeaderViewData(
            labelPackData: LabelPackComponentData(title: "Your Profile", subTitle: "Login to start to search weather data."),
            actionButtonData: ActionButtonData(text: "Login", buttonType: .filled(.sugarLevelColor))
                .setActionButtonListener(by: completion))
    }
    
}
