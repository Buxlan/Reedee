//
//  MatchResultDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import UIKit
import FirebaseDatabase

class MatchResultDetailViewController: UIViewController {
    
    // MARK: - Properties
    typealias InputDataType = MatchResult
    enum EditMode {
        case new
        case edit(InputDataType)
    }
    private var editingObject: InputDataType   
    var viewModel = TableViewBase()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.other3.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        view.register(MatchResultTableCell.self, forCellReuseIdentifier: MatchResultViewConfigurator.reuseIdentifier)
        return view
    }()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
    
    private var keyboardManager = KeyboardAppearanceManager()
        
    // MARK: - Init
    
    init(editMode: EditMode) {
        switch editMode {
        case .new:
            editingObject = InputDataType()
        case .edit(let data):
            editingObject = data
        }
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
        keyboardManager.register(scrollView: tableView)
        configureBars()
        configureViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        keyboardManager.unregister()
        super.viewWillDisappear(animated)
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
        title = L10n.MatchResult.navigationBarTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let itemReport = UIBarButtonItem(title: L10n.Other.report, style: .plain, target: self, action: #selector(handleReport))
        let itemEdit = UIBarButtonItem(title: L10n.Other.edit, style: .plain, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItems = [itemReport, itemEdit]
    }
    
    private func configureViewModel() {
        viewModel.setupTable(tableView)
        let dataSource = createDataSource()
        viewModel.updateDataSource(dataSource)
    }
    
}

extension MatchResultDetailViewController {
    
    func createDataSource() -> TableDataSource {
        var sections: [TableSection] = []
        var section = TableSection()
        let matchResultRow = makeMatchResultTableRow()
        section.addRows([matchResultRow])
        sections.append(section)
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeMatchResultTableRow() -> TableRow {
        var cellModel = MatchResultTableCellModel(data: editingObject)
        cellModel.likeAction = { (state: Bool) in
            self.editingObject.setLike(state)
        }
        let config = MatchResultViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config)
        return row
    }
    
    func makeSaveTableRow() -> TableRow {
        var cellModel = SaveCellModel()
        cellModel.saveAction = {
            do {
                try self.editingObject.save()
            } catch {
                print("Save error: \(error)")
            }
            self.navigationController?.popViewController(animated: true)
        }
        let config = SaveViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config)
        return row
    }
    
    @objc private func handleReport() {
        
    }
    
    @objc private func handleEdit() {
        let vc = MatchResultEditViewController(editMode: .edit(self.editingObject))
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
