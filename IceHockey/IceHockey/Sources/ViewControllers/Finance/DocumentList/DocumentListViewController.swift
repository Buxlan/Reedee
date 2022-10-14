//
//  DocumentListViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import SnapKit
import FirebaseDatabase

class DocumentListViewController: UIViewController {
    
    // MARK: - Properties

    var tableBase = TableViewBase()
    var viewModel = DocumentListViewModel()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Finance.Transactions.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let addOperationDocumentAction = UIAlertAction(title: L10n.Document.addVarious,
                                                       style: .default) { _ in
            let vc = EditOperationDocumentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let addIncreaseDocumentAction = UIAlertAction(title: L10n.Document.addIncreases,
                                                      style: .default) { _ in
            let vc = EditOperationDocumentViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let addDecreaseDocumentAction = UIAlertAction(title: L10n.Document.addDecreases,
                                                      style: .default) { _ in
            let vc = AppendTransactionsStepByStepViewController(type: .cost)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(addOperationDocumentAction)
        controller.addAction(addIncreaseDocumentAction)
        controller.addAction(addDecreaseDocumentAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    @objc private func alertBarButtonPressed() {
        print("Pressed")
    }
    
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
        view.separatorStyle = .singleLine
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 60
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = true
        view.register(DocumentTableCell.self,
                      forCellReuseIdentifier: DocumentViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private let tableFooterView = UIView()
        
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
        title = L10n.Document.listTitle
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
        viewModel.update()
        
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
    }
    
}

// MARK: Table view configuring

extension DocumentListViewController {
    
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
    
}

extension DocumentListViewController {
    
    func makeTableSectionDocuments() -> TableSection {
        
        var section = TableSection()
        
        guard !viewModel.sections.isEmpty else {
            return section
        }
        
        let rows = viewModel.sections[0].documents.map { document in
            makeDocumentTableRow(document: document)
        }
        
        section.addRows(rows)
        return section
    }
    
}

extension DocumentListViewController {
    
    func makeDocumentTableRow(document: Document) -> TableRow {
        let cellModel = DocumentCellModel(document: document)
        let config = DocumentViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.action = { [weak self, document] indexPath in
            guard let self = self else {
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: false)
            let vc = OperationDocumentDetailViewController()
            vc.document = document
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return row
    }
    
}

// MARK: - Actions

extension DocumentListViewController {
    
    @objc private func appendEventHandle() {
        if let popoverController = alert.popoverPresentationController {
//            popoverController.barButtonItem = UIBarButtonItem(title: "Press", style: .plain, target: self, action: #selector(alertBarButtonPressed))
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX + 50, y: self.view.bounds.maxY-50, width: 200, height: 100)
            popoverController.permittedArrowDirections = []
        }
        
        present(alert, animated: true)
    }
    
}
