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
        view.backgroundColor = .white
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.sectionHeaderHeight = 100
        view.estimatedSectionHeaderHeight = 100
        view.tableHeaderView = tableHeaderView
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        view.register(SettingTableCell.self,
                      forCellReuseIdentifier: SettingViewConfigurator.reuseIdentifier)
        view.register(ProfileInfoTableCell.self,
                      forCellReuseIdentifier: ProfileInfoViewConfigurator.reuseIdentifier)
        view.register(TitleHeaderView.self,
                      forHeaderFooterViewReuseIdentifier: AuthHeaderViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
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
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSectionMainInfo(),
            makeTableSectionAuth(),
            makeTableSectionOperations()
        ]
    }
    
}

extension SettingsViewController {
    
    func makeTableSectionMainInfo() -> TableSection {
        var section = TableSection()
        let rows = [
            makeProfileInfoTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionAuth() -> TableSection {
        var section = TableSection()
        let model = AuthHeaderModel(title: L10n.Profile.authSectionTitle)
        let config = AuthHeaderViewConfigurator(data: model)
        section.headerConfig = config
        section.headerHeight = 50
        section.headerViewId = type(of: config).reuseIdentifier
        
        let rows = [
            makeSignUpTableRow(),
            makeSignInTableRow(),
            makeLogoutTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionOperations() -> TableSection {
        var section = TableSection()
        let model = AuthHeaderModel(title: L10n.Profile.operationsSectionTitle)
        let config = AuthHeaderViewConfigurator(data: model)
        section.headerConfig = config
        section.headerHeight = 50
        section.headerViewId = type(of: config).reuseIdentifier
        
        let newEventRow = makeEventTableRow(),
            newMatchResultRow = makeMatchResultTableRow()
        section.addRows([newEventRow, newMatchResultRow])
        return section
    }
    
}

extension SettingsViewController {
    
    func makeEventTableRow() -> TableRow {
        let setting = Setting.newEvent
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeSignUpTableRow() -> TableRow {
        let setting = Setting.signUp
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeLogoutTableRow() -> TableRow {
        let setting = Setting.logout
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeSignInTableRow() -> TableRow {
        let setting = Setting.signIn
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            let vc = SignInViewController()
            vc.modalTransitionStyle = .crossDissolve
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return row
    }
    
    func makeMatchResultTableRow() -> TableRow {
        let setting = Setting.newMatchResult
        let cellModel = SettingCellModel(title: setting.description,
                                         hasDisclosure: setting.hasDisclosure)
        let config = SettingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeProfileInfoTableRow() -> TableRow {
        let cellModel = ProfileInfoCellModel(username: "Buxlan", image: nil)
        let config = ProfileInfoViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
}
