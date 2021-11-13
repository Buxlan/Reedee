//
//  SettingsViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit
import FirebaseDatabase

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = TableViewBase()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.accent1.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = tableHeaderView
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        view.register(SettingTableCell.self, forCellReuseIdentifier: SettingViewConfigurator.reuseIdentifier)
        return view
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tableFooterView: UIView = {
        let view = UIView()
        return view
    }()
        
    // MARK: - Init
    
    override func viewDidLoad() {
        view.backgroundColor = Asset.accent1.color
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
        configureViewModel()
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.Settings.navigationBarTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureViewModel() {
        viewModel.setupTable(tableView)
        let dataSource = createDataSource()
        viewModel.updateDataSource(dataSource)
    }
    
}

extension SettingsViewController {
    
    func createDataSource() -> TableDataSource {
        var sections: [TableSection] = []
        var section = TableSection()
        let signUpRow = makeSignUpTableRow(),
            addEventRow = makeAddEventTableRow()
        section.addRows([signUpRow, addEventRow])
        sections.append(section)
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeAddEventTableRow() -> TableRow {
        let setting = Setting.addEvent
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Add event", message: "Sorry, not implemented yet", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            self.present(alertController, animated: true)
        }
        return row
    }
    
    func makeSignUpTableRow() -> TableRow {
        let setting = Setting.signUp
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Sign up", message: "Sorry, not implemented yet", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            self.present(alertController, animated: true)
        }
        return row
    }
    
}
