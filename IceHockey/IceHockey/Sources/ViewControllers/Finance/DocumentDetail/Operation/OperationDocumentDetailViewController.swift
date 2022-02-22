//
//  OperationDocumentDetailViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import SnapKit

class OperationDocumentDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var document: Document! {
        didSet {
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
    
    var tableBase = TableViewBase()
    var viewModel = OperationDocumentDetailViewModel()
    
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
        view.tableHeaderView = tableHeaderView
        view.showsVerticalScrollIndicator = true
        view.register(OperationDocumentTableRowTableCell.self,
                      forCellReuseIdentifier: OperationDocumentTableRowViewConfigurator.reuseIdentifier)
        view.register(DetailDocumentTableSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailDocumentTableSectionHeaderViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableHeaderView: DetailOperationDocumentTableHeaderView = {
        let viewModel = DetailDocumentHeaderViewModel(data: self.viewModel.document)
        let frame = CGRect(x: 0, y: 0, width: 0, height: 105)
        let view = DetailOperationDocumentTableHeaderView(frame: frame)
        view.configure(data: viewModel)
        
        return view
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
        title = L10n.Document.Operation.title
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
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

extension OperationDocumentDetailViewController {
    
    func createDataSource() -> TableDataSource {
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSectionDocuments()
        ]
    }
    
    func makeTableSectionDocuments() -> TableSection {
        
        var section = TableSection()
        
        guard viewModel.document != nil else {
            return section
        }

        let model = DetailDocumentTableSectionHeaderViewModel(data: self.document)
        let headerConfig = DetailDocumentTableSectionHeaderViewConfigurator(data: model)
        section.headerConfig = headerConfig
        section.headerHeight = UITableView.automaticDimension
        section.headerViewId = type(of: headerConfig).reuseIdentifier
        
        let rows = viewModel.document.table.rows.compactMap { row in
            makeDocumentTableRow(row: row)
        }
        
        section.addRows(rows)
        return section
    }

    func makeDocumentTableRow(row: DocumentTableRow) -> TableRow? {
        guard let tableRowData = row as? OperationDocumentTableRow else { return nil }
        
        let cellModel = OperationDocumentTableRowCellModel(data: tableRowData)
        let config = OperationDocumentTableRowViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config,
                           height: UITableView.automaticDimension)
        return row
    }
    
}
