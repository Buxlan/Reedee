//
//  BaseTableViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 16.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseTableViewController<ViewModelType: BaseViewModel>: BaseViewController<ViewModelType>, BaseTableViewProtocol {
    
    var tableBase = TableViewBase()
    var tableView = UITableView()
    var onCompletion: CompletionBlock?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureInterface() {
        
        view.backgroundColor = Colors.Gray.ultraLight
        view.addSubview(tableView)
        
        configureTableView()
        configureConstraints()
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = Colors.Gray.ultraLight
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.allowsSelectionDuringEditing = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    override func configureViewModel() {
        viewModel.uiRefreshHandler = { [weak self] in
            guard let self = self else { return }
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
        viewModel.updateData()
    }
    
    func createDataSource() -> TableDataSource {
        let sections = [TableSection()]
        let dataSource = TableDataSource(sections: sections)
        
        return dataSource
    }
    
}
