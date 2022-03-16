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
        view.register(DetailDocSectionView.self,
                      forHeaderFooterViewReuseIdentifier: DetailDocSectionViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableHeaderView: DetailOperationDocTableHeaderView = {
        let viewModel = DetailDocumentHeaderViewModel(data: self.viewModel.document)
        let frame = CGRect(x: 0, y: 0, width: 0, height: 105)
        let view = DetailOperationDocTableHeaderView(frame: frame)
        view.configure(data: viewModel)
        
        return view
    }()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Other.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: L10n.Other.edit, style: .default) { _ in
            self.editEvent()
        }
        let reportAction = UIAlertAction(title: L10n.Other.bugReport, style: .destructive) { _ in
            self.report()
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(editAction)
        controller.addAction(reportAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    private lazy var menuImage: UIImage = {
        let imageHeight: CGFloat = 32.0
        return Asset.menu.image.resizeImage(to: imageHeight, aspectRatio: .current)
        
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
        
        let menuItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
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

        let model = DetailDocSectionHeaderViewModel(data: viewModel.document)
        let headerConfig = DetailDocSectionViewConfigurator(data: model)
        section.headerConfig = headerConfig
        section.headerHeight = UITableView.automaticDimension
        section.headerViewId = type(of: headerConfig).reuseIdentifier
        
        var orderNumber = 0
        
        let rows: [TableRow] = viewModel.document.table.rows.compactMap { row in
            guard let tableRowData = row as? OperationDocumentTableRow else { return nil }
            orderNumber += 1
            return makeDocumentTableRow(row: tableRowData,
                                        orderNumber: orderNumber)
        }
        
        section.addRows(rows)
        return section
    }

    func makeDocumentTableRow(row: OperationDocumentTableRow, orderNumber: Int)
    -> TableRow {
        
        let cellModel = OperationDocumentTableRowCellModel(data: row,
                                                           index: row.index,
                                                           orderNumber: orderNumber)
        let config = OperationDocumentTableRowViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config,
                           height: UITableView.automaticDimension)
        return row
    }
    
}

// MARK: - Actions

extension OperationDocumentDetailViewController {
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
    @objc private func report() {
        
    }
    
    @objc private func editEvent() {
        DocumentCoordinator.shared.goToDocumentEditing(document: viewModel.document)
    }
    
}
