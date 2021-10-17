//
//  AccountViewController.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

class AccountViewController: BaseViewController<AccountViewModel> {
    
    private var mainComponent: ItemListView!
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        view.backgroundColor = .yellow
        
        appendMainComponent()
        subscribeViewModelPublishers()
        viewModel.getViewComponentData()
    }
    
    private func appendMainComponent() {
        
        mainComponent = ItemListView(data: viewModel.getItemListViewData())
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        
        mainComponent.delegate = viewModel
        
        view.addSubview(mainComponent)
        
        NSLayoutConstraint.activate([
        
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
        
    }
    
    private func subscribeViewModelPublishers() {
        viewModel.subscribeViewState { [weak self] state in
            switch state {
            case .loading:
                break
            case .done:
                self?.mainComponent.reloadTableView()
            default:
                break
            }
        }
        
        viewModel.subscribeLoginAction { [weak self] in
            self?.userLoginStateHandler()
        }
    }
    
    private func userLoginStateHandler() {
        present(LoginViewBuilder.build(), animated: true, completion: nil)
    }
    
}
