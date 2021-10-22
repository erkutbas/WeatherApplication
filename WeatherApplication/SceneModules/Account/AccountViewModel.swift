//
//  AccountViewModel.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import Foundation

typealias AccountViewState = (ViewState) -> Void

class AccountViewModel {
    
    private let formatter: AccountViewDataProtocol
    private let authenticationManager: AuthenticationManagerProtocol
    
    private var state: AccountViewState?
    private var loginActionBlock: VoidBlock?
    private var data = [GenericDataProtocol]()
    
    init(formatter: AccountViewDataProtocol,
         authenticationManager: AuthenticationManagerProtocol) {
        self.formatter = formatter
        self.authenticationManager = authenticationManager
        subscribeAuthenticationManager()
    }
    
    func subscribeViewState(with completion: @escaping AccountViewState) {
        state = completion
    }
    
    func subscribeLoginAction(with completion: @escaping VoidBlock) {
        loginActionBlock = completion
    }
    
    func getItemListViewData() -> ItemListViewData {
        return ItemListViewData(headerViewData: formatter.getHeaderViewData(with: loginActionButtonListener))
    }
    
    // MARK: - Private Methods
    private func subscribeAuthenticationManager() {
        authenticationManager.isLoggedIn(with: isLoggedInListener)
        
        AuthenticationManager.shared.toko { zozo in
            print("zozo1 : \(zozo)")
        }
    }
    
    private func loggedInListenerHandler(with value: Bool) {
        state?(.loading)
        data = formatter.getAccountViewComponentData(by: value)
        state?(.done)
    }
    
    private func selectedItemHandler(at index: Int) {
        switch data[index].type {
        case .logout:
            authenticationManager.logout()
        default:
            break
        }
    }
    
    // MARK: - Listener Handlers
    private lazy var loginActionButtonListener: VoidBlock = { [weak self] in
        print("button tapped")
        self?.loginActionBlock?()
    }
    
    private lazy var isLoggedInListener: BooleanBlock = { [weak self] value in
        print("test : \(value)")
        self?.loggedInListenerHandler(with: value)
    }
    
}

extension AccountViewModel: ItemListProtocol {
    
    func askData(at index: Int) -> GenericDataProtocol? {
        return data[index]
    }
    
    func askNumberOfItem(in section: Int) -> Int {
        return data.count
    }
    
    func askNumberOfSection() -> Int {
        return 1
    }
    
    func selectedItem(at index: Int) {
        selectedItemHandler(at: index)
    }
    
}
