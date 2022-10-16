//
//  TransactionsConfirmViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import SnapKit
import FirebaseDatabase

class TransactionsConfirmViewController: UIViewController {
    
    // MARK: - Properties
    
    var onNext = {}
    var onBack = {}
    var viewModel: TransactionsConfirmViewModel
    
    private var type: TransactionType
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
    
    private lazy var tableFooterView: TransactionConfirmTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 80)
        let view = TransactionConfirmTableFooterView(frame: frame)
        view.onConfirm = { [weak self] in
            self?.onNext()
        }
        view.onBack = { [weak self] in
            self?.onBack()
        }
        return view
    }()
        
    // MARK: - Lifecircle
    
    init(type: TransactionType, viewModel: TransactionsConfirmViewModel) {
        self.type = type
        self.viewModel = viewModel
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
        title = L10n.Finance.Transactions.title
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
    }
    
}

// MARK: Table view configuring

extension TransactionsConfirmViewController {
    
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

extension TransactionsConfirmViewController {
    
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

    func makeTransactionTableRow(transaction: FinanceTransaction, order: Int) -> TableRow {
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
