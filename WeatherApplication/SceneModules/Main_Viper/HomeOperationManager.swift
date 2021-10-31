//
//  HomeOperationManager.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 31.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class HomeOperationManager: HomeOperationProtocol {
    
    private let accessProviderManager: AccessProviderProtocol
    
    init(accessProviderManager: AccessProviderProtocol) {
        self.accessProviderManager = accessProviderManager
    }
    
    func getData(with completion: @escaping CharacterDataBlock) {
        do {
            guard let urlRequest = try? CharacterListServiceProvider(request: getCharacterListRequest()).returnUrlRequest() else { return }
            fireApiCall(with: urlRequest, with: completion)
        }
    }
    
    private func fireApiCall(with request: URLRequest, with completion: @escaping (Result<CharacterDataResponse, ErrorResponse>) -> Void) {
        
        ApiManagerBuilder.build().executeRequest(urlRequest: request, completion: completion)
        
    }
    
    private func getCharacterListRequest() -> CharacterDataRequest {
        return CharacterDataRequest(
            offset: 0,
            limit: 50,
            ts: accessProviderManager.returnUniqueData(),
            apikey: accessProviderManager.returnApiKey(),
            hash: accessProviderManager.returnHash())
    }
    
}
