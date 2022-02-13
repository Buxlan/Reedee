//
//  FinanceReportBalanceViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import SnapKit

class FinanceReportBalanceViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = FinanceBalanceViewModel()
    
    private var tableBase = TableViewBase()
    
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
        view.register(TransactionTableCell.self,
                      forCellReuseIdentifier: TransactionViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableFooterView: FinanceBalanceExportTableFooterView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: 0,
                           height: FinanceBalanceExportTableFooterView.height)
        let view = FinanceBalanceExportTableFooterView(frame: frame)
        view.onAction = { [weak self] in
            let vc = FinanceTextReportViewController()
            vc.text = self?.viewModel.exportBalance() ?? ""
            vc.modalTransitionStyle = .crossDissolve
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return view
    }()
        
    // MARK: - Lifecircle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.backgroundColor = Asset.accent1.color
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
        title = L10n.Finance.balance
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureViewModel() {
        viewModel.shouldTableRefresh = { [weak self] in
            guard let self = self else { return }
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
        
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
        viewModel.update()
    }
    
}

// MARK: Table view configuring

extension FinanceReportBalanceViewController {
    
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

    func makeTableSectionTransactions() -> TableSection {
        
        var section = TableSection()
        
        guard !viewModel.sections.isEmpty else {
            return section
        }
        
        var order = 0
        let rows = viewModel.sections[0].transactions.map { transaction -> TableRow in
            order += 1
            return makeTransactionTableRow(transaction: transaction, order: order)
        }

        section.addRows(rows)
        return section
    }

    func makeTransactionTableRow(transaction: FinanceTransaction, order: Int)
    -> TableRow {
        let cellModel = TransactionCellModel(transaction: transaction, isShowOrder: true, order: order)
        let config = TransactionViewConfigurator(data: cellModel)
        let row = TableRow(rowId: Swift.type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
//            fatalError()
        }
        return row
    }
    
}
