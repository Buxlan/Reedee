//
//  EditOperationDocumentViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.03.2022.
//

import SnapKit

class EditOperationDocumentViewController: UIViewController {
    
    // MARK: - Properties
    
    var document: Document! {
        didSet {
            title = L10n.Document.Operation.editTitle
            if let proxy = document as? DocumentProxy,
               let document = proxy.object as? OperationDocument {
                viewModel.document = document
            } else if let document = document as? OperationDocument {
                viewModel.document = document
            } else {
                assertionFailure()
                fatalError()
            }
        }
    }
    
    var tableBase = LeadingSwipableTableViewBase(actionTitle: L10n.Other.delete,
                                                 actionColor: .red)
    var viewModel = EditOperationDocumentViewModel()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.allowsSelection = false
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 60
        view.tableHeaderView = tableHeaderView
        view.showsVerticalScrollIndicator = true
        view.register(EditTransactionCell.self,
                      forCellReuseIdentifier: EditTransactionViewConfigurator.reuseIdentifier)
        view.register(EditDocSectionView.self,
                      forHeaderFooterViewReuseIdentifier: EditDocSectionViewConfigurator.reuseIdentifier)
        view.register(EditDocSectionFooterView.self,
                      forHeaderFooterViewReuseIdentifier: EditDocSectionFooterViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableHeaderView: EditOperationDocHeaderView = {
        let viewModel = DetailDocumentHeaderViewModel(data: viewModel.document)
        let frame = CGRect(x: 0, y: 0, width: 0, height: 200)
        let view = EditOperationDocHeaderView(delegate: self, frame: frame)
        view.configure(data: viewModel)
        
        return view
    }()
    
    private var keyboardManager = KeyboardAppearanceManager()
        
    // MARK: - Lifecircle
    
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
        title = L10n.Document.Operation.newTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let menuItem = UIBarButtonItem(title: L10n.Other.save,
                                       style: .done,
                                       target: self, action: #selector(saveHandle))
        navigationItem.rightBarButtonItem = menuItem
    }
    
    private func configureViewModel() {
        viewModel.onRefresh = { [weak self] in
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

extension EditOperationDocumentViewController {
    
    func createDataSource() -> TableDataSource {
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSectionIncreaseTransactions(),
            makeTableSectionDecreaseTransactions()
        ]
    }
    
    func makeTableSectionIncreaseTransactions() -> TableSection {
        
        var section = TableSection()

        var model = DetailDocSectionHeaderViewModel(data: viewModel.document)
        model.onAppend = { [weak self] in
            guard let self = self else { return }
            let index = self.viewModel.document.table.getNewRowIndex()
            let row = OperationDocumentTableRow(type: .income, index: index)
            self.viewModel.document.table.rows.insert(row, at: 0)
            self.viewModel.update()
        }
        let headerConfig = EditDocSectionViewConfigurator(data: model)
        section.headerConfig = headerConfig
        section.headerHeight = UITableView.automaticDimension
        section.headerViewId = type(of: headerConfig).reuseIdentifier
        let footerModel = DetailDocSectionFooterViewModel(data: viewModel.document,
                                                          type: .income)
        let footerConfig = EditDocSectionFooterViewConfigurator(data: footerModel)
        section.footerConfig = footerConfig
        section.footerHeight = UITableView.automaticDimension
        section.footerViewId = type(of: footerConfig).reuseIdentifier
        
        var orderNumber = 0
        
        let rows: [TableRow] = viewModel.document.table.rows.compactMap { row in
            guard let tableRowData = row as? OperationDocumentTableRow,
                  row.type == .income else {
                return nil
            }
            orderNumber += 1
            return makeDocumentTableRow(data: tableRowData, orderNumber: orderNumber)
        }
        
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionDecreaseTransactions() -> TableSection {
        
        var section = TableSection()

        var model = DetailDocSectionHeaderViewModel(data: viewModel.document)
        model.onAppend = { [weak self] in
            guard let self = self else { return }
            let index = self.viewModel.document.table.getNewRowIndex()
            let row = OperationDocumentTableRow(type: .cost, index: index)
            self.viewModel.document.table.rows.insert(row, at: 0)
            self.viewModel.update()
        }
        let headerConfig = EditDocSectionViewConfigurator(data: model)
        section.headerConfig = headerConfig
        section.headerHeight = UITableView.automaticDimension
        section.headerViewId = type(of: headerConfig).reuseIdentifier
        
        let footerModel = DetailDocSectionFooterViewModel(data: viewModel.document,
                                                          type: .cost)
        let footerConfig = EditDocSectionFooterViewConfigurator(data: footerModel)
        section.footerConfig = footerConfig
        section.footerHeight = UITableView.automaticDimension
        section.footerViewId = type(of: footerConfig).reuseIdentifier
        
        var orderNumber = 0
        
        let rows: [TableRow] = viewModel.document.table.rows.compactMap { row in
            guard let tableRowData = row as? OperationDocumentTableRow,
                  row.type == .cost else {
                return nil
            }
            orderNumber += 1
            return makeDocumentTableRow(data: tableRowData, orderNumber: orderNumber)
        }
        
        section.addRows(rows)
        return section
    }

    func makeDocumentTableRow(data: OperationDocumentTableRow,
                              orderNumber: Int) -> TableRow {
        
        var cellModel = OperationDocumentTableRowCellModel(data: data,
                                                           index: data.index,
                                                           orderNumber: orderNumber)
        cellModel.delegate = self
        let config = EditTransactionViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config,
                           height: UITableView.automaticDimension)
        row.contextualAction = { [weak self] _, _, _ in
            log.debug("Deleting transaction row")
            self?.viewModel.deleteRow(data)
        }
        return row
    }
    
}

// MARK: - EditOperationDocumentHeaderView Delegate

extension EditOperationDocumentViewController: EditOperationDocHeaderViewDelegate {
    
    func didChanged(number: String) {
        viewModel.document.number = number
    }
    
    func didChanged(comment: String) {
        viewModel.document.comment = comment
    }
    
    func onSelectDate() {
        let vc = CalendarViewController(selectedDates: [self.viewModel.document.date])
        vc.onReady = { [weak self] dates in
            guard let date = dates.first else {
                return
            }
            self?.viewModel.document.date = date
            self?.tableHeaderView.configureDatePickerButton(startDate: date,
                                                            endDate: dates.last)
            self?.viewModel.update()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK: - EditTransactionCellDelegate

extension EditOperationDocumentViewController: EditTransactionCellDelegate {
    
    func didChanged(name: String, at index: Int) {
        if let index = viewModel.document.table.rows
            .firstIndex(where: { $0.index == index }) {
            viewModel.document.table.rows[index].name = name
        }
    }
    
    func didChanged(number: String, at index: Int) {
        if let index = viewModel.document.table.rows
            .firstIndex(where: { $0.index == index }) {
            viewModel.document.table.rows[index].number = number
        }
    }
    
    func didChanged(amount: Double, at index: Int) {
        if let index = viewModel.document.table.rows
            .firstIndex(where: { $0.index == index }) {
            viewModel.document.table.rows[index].amount = amount
        }
    }
    
    func didChanged(comment: String, at index: Int) {
        if let index = viewModel.document.table.rows
            .firstIndex(where: { $0.index == index }) {
            viewModel.document.table.rows[index].comment = comment
        }
    }
    
}

// MARK: - Actions

extension EditOperationDocumentViewController {
    
    @objc private func saveHandle() {
        viewModel.save()
    }
    
}
