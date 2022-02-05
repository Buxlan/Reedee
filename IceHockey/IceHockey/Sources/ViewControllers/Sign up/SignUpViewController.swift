//
//  SignUpViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import SnapKit
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    var tableBase = TableViewBase()
    var viewModel = SettingsViewModel()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
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
    
    private lazy var tableFooterView = UIView()
        
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
        view.backgroundColor = Colors.Accent.blue
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
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
        viewModel.configure()
        viewModel.onTableRefresh = { [weak self] in
            guard let self = self else { return }
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
    }
    
}

extension SignUpViewController {
    
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

extension SignUpViewController {
    
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

extension SignUpViewController {
    
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
        
    func makeProfileInfoTableRow() -> TableRow {
        var cellModel: ProfileInfoCellModel
        if let user = viewModel.user {
            cellModel = ProfileInfoCellModel(user: user)
        } else {
            cellModel = ProfileInfoCellModel()
        }
        let config = ProfileInfoViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
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
    
}

