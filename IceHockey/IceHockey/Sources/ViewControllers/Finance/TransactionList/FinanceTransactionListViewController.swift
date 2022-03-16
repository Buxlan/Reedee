//
//  FinanceTransactionListViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import SnapKit

class FinanceTransactionListViewController: UIViewController {
    
    // MARK: - Properties
    
    var tableBase = LeadingSwipableTableViewBase(actionTitle: L10n.Finance.Transactions.switchActivity,
                                                 actionColor: .blue)
    var viewModel = FinanceTransactionListViewModel()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Finance.Transactions.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let incomeAction = UIAlertAction(title: L10n.Finance.Transactions.addIncome, style: .default) { _ in
            let vc = AppendTransactionsStepByStepViewController(type: .income)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let costsAction = UIAlertAction(title: L10n.Finance.Transactions.addCosts, style: .default) { _ in
            let vc = AppendTransactionsStepByStepViewController(type: .cost)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(incomeAction)
        controller.addAction(costsAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    private lazy var appendEventImage: UIImage = {
        Asset.plus.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
    }()
    
    private lazy var appendEventButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "appendEventButton"
        view.backgroundColor = Asset.accent1.color
        view.tintColor = Asset.other3.color
        view.addTarget(self, action: #selector(appendEventHandle), for: .touchUpInside)
        view.setImage(appendEventImage, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        view.isHidden = false
        return view
    }()
    
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
        view.estimatedRowHeight = 60
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = true
        view.register(TransactionTableCell.self,
                      forCellReuseIdentifier: TransactionViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableFooterView: TransactionListTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 80)
        let view = TransactionListTableFooterView(frame: frame)
        view.configure(amount: 0.0)
        return view
    }()
    
    private lazy var searchResultsViewController: SearchTransactionListViewController = {
        let vc = SearchTransactionListViewController()
        return vc
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: searchResultsViewController)
        controller.searchResultsUpdater = self
//        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = L10n.Finance.searchPlaceholder
        controller.searchBar.barStyle = .default
        controller.hidesNavigationBarDuringPresentation = true
//        controller.searchBar.setShowsCancelButton(true, animated: true)
        
        if let textField = controller.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
            textField.clearButtonMode = .always
            textField.tintColor = .white
            textField.isOpaque = true
            guard textField.subviews.count > 0 else {
                print("Warning: textField seach bar view has no subviews. It's very strange!")
                return controller
            }
            textField.subviews[0].backgroundColor = .white
            textField.subviews[0].tintColor = .white
        }
        guard controller.searchBar.subviews.count > 0 else {
            print("Warning: seach bar view has no subviews. It's very strange!")
            return controller
        }
        controller.searchBar.subviews[0].backgroundColor = Colors.Accent.blue
        controller.searchBar.subviews[0].tintColor = .white
        return controller
    }()
        
    // MARK: - Lifecircle
    
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
        configureSearchController()
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.backgroundColor = Asset.accent1.color
        view.addSubview(tableView)
        view.addSubview(appendEventButton)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        appendEventButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-32)
            make.width.height.equalTo(44)
        }
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.Finance.Transactions.title
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.showsSearchResultsButton = true
        searchController.searchBar.isOpaque = true
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.tintColor = .black
        
        definesPresentationContext = true
    }
    
    private func configureViewModel() {
        viewModel.shouldTableRefresh = { [weak self] in
            guard let self = self else { return }
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
        viewModel.update()
        
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
    }
    
}

// MARK: Table view configuring

extension FinanceTransactionListViewController {
    
    func createDataSource() -> TableDataSource {
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSectionTransactions()
        ]
    }
    
}

extension FinanceTransactionListViewController {
    
    func makeTableSectionTransactions() -> TableSection {
        
        var section = TableSection()
        
        guard !viewModel.sections.isEmpty else {
            return section
        }
        
        let rows = viewModel.sections[0].transactions.map { transaction in
            makeTransactionTableRow(transaction: transaction)
        }
        
        section.addRows(rows)
        return section
    }
    
}

// MARK: - UISearchBarDelegate

extension FinanceTransactionListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let filter = searchController.searchBar.text ?? ""
        searchResultsViewController
            .viewModel
            .update(sections: viewModel.sections,
                    filter: filter)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//        navigationController?.popViewController(animated: true)
//    }
}

extension FinanceTransactionListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        let filter = searchController.searchBar.text ?? ""
//        searchResultsViewController
//            .viewModel
//            .update(sections: viewModel.sections,
//                    filter: filter)
    }
}

extension FinanceTransactionListViewController: UISearchControllerDelegate {
    
    
    
}

extension FinanceTransactionListViewController {
    
    func makeTransactionTableRow(transaction: FinanceTransaction) -> TableRow {
        let cellModel = TransactionCellModel(transaction: transaction)
        let config = TransactionViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: false)
            let balance = self.viewModel.getBalance(number: transaction.number)
            self.tableFooterView.configure(amount: balance)
        }
        row.contextualAction = { [weak self] _, _, _ in
            log.debug("Switch activity of transaction \(transaction.objectIdentifier)")
            self?.viewModel.switchActivity(of: transaction) { result in
                log.debug("FinanceTransactionListViewController: activity switched")
            }
        }
        return row
    }
    
}

// MARK: - Actions

extension FinanceTransactionListViewController {
    
    @objc private func appendEventHandle() {
        present(alert, animated: true)
    }
    
}
