//
//  HomeOperationProtocol.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 31.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

typealias CharacterDataBlock = (Result<CharacterDataResponse, ErrorResponse>) -> Void

protocol HomeOperationProtocol {
    
    func getData(with completion: @escaping CharacterDataBlock)
    
}
