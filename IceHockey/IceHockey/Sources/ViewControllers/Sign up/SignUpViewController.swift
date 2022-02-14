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
    
    private var keyboardManager = KeyboardAppearanceManager()
    
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
        view.register(LoginInputTableCell.self,
                      forCellReuseIdentifier: LoginInputViewConfigurator.reuseIdentifier)
        view.register(EmailInputTableCell.self,
                      forCellReuseIdentifier: EmailInputViewConfigurator.reuseIdentifier)
        view.register(PasswordInputTableCell.self,
                      forCellReuseIdentifier: PasswordInputViewConfigurator.reuseIdentifier)
        view.register(ConfigurableButtonTableCell.self,
                      forCellReuseIdentifier: ConfigurableButtonViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 10
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
        keyboardManager.register(scrollView: tableView)
        configureBars()
        configureViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManager.unregister()
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
        title = L10n.SignUp.title
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

// MARK: - Table view configure

extension SignUpViewController {
    
    func createDataSource() -> TableDataSource {
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSection()
        ]
    }
   
    func makeTableSection() -> TableSection {
        var section = TableSection()
//        let model = AuthHeaderModel(title: L10n.Profile.authSectionTitle)
//        let config = AuthHeaderViewConfigurator(data: model)
//        section.headerConfig = config
//        section.headerHeight = 50
//        section.headerViewId = type(of: config).reuseIdentifier
        
        let rows = [
            makeLoginTableRow(),
            makeEmailTableRow(),
            makePasswordTableRow(),
            makeRepeatPasswordTableRow(),
            makeSignUpButtonTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
}

extension SignUpViewController {
    
    func makeLoginTableRow() -> TableRow {
        let cellModel = TextInputCellModel(value: "")
        let config = LoginInputViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeEmailTableRow() -> TableRow {
        let cellModel = TextInputCellModel(value: "")
        let config = EmailInputViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makePasswordTableRow() -> TableRow {
        let cellModel = TextInputCellModel(value: "")
        let config = PasswordInputViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeRepeatPasswordTableRow() -> TableRow {
        let cellModel = TextInputCellModel(value: "",
                                           placeholderText: L10n.Auth.repeatPasswordPlaceholder)
        let config = PasswordInputViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
    func makeSignUpButtonTableRow() -> TableRow {
        let cellModel = ButtonCellModel(text: L10n.Auth.signUp)
        let config = ConfigurableButtonViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            fatalError()
        }
        return row
    }
    
}

