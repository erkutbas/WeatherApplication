//
//  ItemDetailDataFormatter.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 24.10.2021.
//

import Foundation

class ItemDetailDataFormatter: ItemDetailDataFormatterProtocol {
    
    func convertItemDetailView(from rawData: CharacterData) -> ItemDetailViewData {
        
        let title = rawData.name
        let subTitle = rawData.description ?? "Sorry mate, there is no description for this marvel character!"
        let labelPack = LabelPackComponentData(title: title, subTitle: subTitle)
            .setSubTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .center).setTextAlignment(by: .center).setNumberOfLines(by: 0).setLineBreakMode(by: .byWordWrapping).setFont(by: MainFont.regular(18).value))
            .setTitleLabelDistributionData(by: LabelDistributionData().setContentMode(by: .center).setTextAlignment(by: .center).setNumberOfLines(by: 0).setLineBreakMode(by: .byWordWrapping).setFont(by: MainFont.medium(28).value))
            .setSpacing(by: 15)
            .setStackViewAlignment(by: .fill)
        
        return ItemDetailViewData(imageData: createImageData(by: rawData.thumbnail), labelPackData: labelPack)
    }
    
    private func createImageData(by value: Thumbnail) -> CustomImageViewComponentData {
        return CustomImageViewComponentData(imageUrl: "\(value.path)/portrait_incredible.\(value.thumbnailExtension)")
    }
    
}
