//
//  SFSymbolsHelper.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 17.10.2021.
//

import UIKit

enum SFSymbolsHelper: String, GenericValueProtocol {

    typealias Value = UIImage?
    
    var value: UIImage? {
        return UIImage(systemName: rawValue)
    }
    
    case personOutlined = "person.circle"
    case personFilled = "person.circle.fill"
    case gearshape = "gearshape"
    case questionmark = "questionmark.circle"
    
}
