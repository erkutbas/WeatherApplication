//
//  ItemListView.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

class ItemListView: GenericBaseView<ItemListViewData> {
    
    deinit {
        print("DEINIT ItemListView")
    }
    
    weak var delegate: ItemListProtocol?
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        temp.estimatedRowHeight = UITableView.automaticDimension
        temp.separatorStyle = .none
        temp.contentInsetAdjustmentBehavior = .never
        temp.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return temp
    }()
    
    private var headerView: HeaderView?
    
    override func addMajorViewComponents() {
        super.addMajorViewComponents()
        addTableView()
    }
    
    // MARK: - Private Methods
    private func addTableView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    private func addHeaderView() {
        tableView.tableHeaderView = headerView
    }
    
    private func initiateHeaderView() {
        guard let data = returnData() else { return }
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260), data: data.headerViewData)
        addHeaderView()
    }
    
    // MARK: - Public Methods
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = returnData() else { return }
        initiateHeaderView()
    }
    
}

extension ItemListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.askNumberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.askNumberOfItem(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = delegate?.askData(at: indexPath.row) else { fatalError("Please provide data") }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        
        cell.setData(by: data)
        
        return cell
    }
}

