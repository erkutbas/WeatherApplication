//
//  MainViewModel.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import Foundation
import DefaultNetworkOperationPackage

class MainViewModel {
    
    private var loginStateListener: BooleanBlock?
    private var mainViewState: ((ViewState) -> Void)?
    
    private let authenticationManager: AuthenticationManagerProtocol
    private let accessProviderManager: AccessProviderProtocol
    private var dataFormatter: MainViewDataFormatterProtocol
    
    init(authenticationManager: AuthenticationManagerProtocol,
         accessProviderManager: AccessProviderProtocol,
         dataFormatter: MainViewDataFormatterProtocol) {
        self.authenticationManager = authenticationManager
        self.accessProviderManager = accessProviderManager
        self.dataFormatter = dataFormatter
        listenUserState()
    }
    
    func subscribeLoginState(with completion: @escaping BooleanBlock) {
        loginStateListener = completion
    }
    
    func getData() {
        mainViewState?(.loading)
        do {
            guard let urlRequest = try? CharacterListServiceProvider(request: getCharacterListRequest()).returnUrlRequest() else { return }
            fireApiCall(with: urlRequest, with: dataListener)
        }
        
    }
    
    func subscribeViewState(with completion: @escaping (ViewState) -> Void) {
        mainViewState = completion
    }
    
    // MARK: - Private Methods
    private func listenUserState() {
        authenticationManager.isLoggedIn(with: isLoggedInListener)
    }
    
    private func fireApiCall(with request: URLRequest, with completion: @escaping (Result<CharacterListResponse, ErrorResponse>) -> Void) {
        APIManager.shared.executeRequest(urlRequest: request, completion: completion)
    }
    
    private func getCharacterListRequest() -> CharacterListRequest {
        return CharacterListRequest(
            offset: dataFormatter.paginationData.offset,
            limit: dataFormatter.paginationData.limit,
            ts: accessProviderManager.returnUniqueData(),
            apikey: accessProviderManager.returnApiKey(),
            hash: accessProviderManager.returnHash())
    }
    
    private func loggedInListenerHandler(with value: Bool) {
        if value {
            getData()
        }
    }
    
    private func apiCallHandler(from response: CharacterListResponse) {
        dataFormatter.setData(with: response)
        mainViewState?(.done)
    }
    
    // MARK: - Listener Handlers
    private lazy var isLoggedInListener: BooleanBlock = { [weak self] value in
        print("test : \(value)")
        self?.loggedInListenerHandler(with: value)
    }
    
    private lazy var dataListener: (Result<CharacterListResponse, ErrorResponse>) -> Void = { [weak self] result in
        
        self?.dataFormatter.paginationData.fetching = false
        
        switch result {
        case .failure(let error):
            print("error : \(error)")
        case .success(let response):
            self?.apiCallHandler(from: response)
        }
    }
    
}

// MARK: - ItemProviderProtocol
extension MainViewModel: ItemProviderProtocol {
   
    func askNumberOfSection() -> Int {
        return 0
    }
    
    func askNumberOfItem(in section: Int) -> Int {
        return dataFormatter.getNumbeOfItem(in: section)
    }
    
    func askData(at index: Int) -> GenericDataProtocol? {
        return dataFormatter.getItem(at: index)
    }
    
    func isLoadingCell(for index: Int) -> Bool {
        return index >= dataFormatter.getCount()
    }
    
    func getMoreData() {
        // check to get more data
        guard dataFormatter.paginationData.checkLoadingMore() else { return }
        dataFormatter.paginationData.nextOffset()
        getData()
    }
    
}
