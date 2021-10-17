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
    
    private var state: AccountViewState?
    private var loginActionBlock: VoidBlock?
    private var data = [GenericDataProtocol]()
    
    init(formatter: AccountViewDataProtocol) {
        self.formatter = formatter
    }
    
    func getViewComponentData() {
        state?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.data = self.formatter.getAccountViewComponentData()
            self.state?(.done)
        }
        
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
    
    private lazy var loginActionButtonListener: VoidBlock = { [weak self] in
        print("button tapped")
        self?.loginActionBlock?()
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
    
}
