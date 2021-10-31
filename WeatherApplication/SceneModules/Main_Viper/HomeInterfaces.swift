//
//  HomeInterfaces.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 31.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol HomeWireframeInterface: WireframeInterface {
    func goToDetailView(with data: ItemDetailViewRequest)
}

protocol HomeViewInterface: ViewInterface {
    func refreshView()
}

protocol HomePresenterInterface: PresenterInterface, ItemProviderProtocol {
}

protocol HomeFormatterInterface: FormatterInterface {
    func setData(via response: CharacterDataResponse)
    func askData(at index: Int) -> GenericDataProtocol?
    func askNumberOfSection() -> Int
    func askNumberOfItem(in section: Int) -> Int
    func getItemId(at index: Int) -> ItemDetailViewRequest
}

protocol HomeInteractorInterface: InteractorInterface {
    func getData(with completion: @escaping CharacterDataBlock)
}