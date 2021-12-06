//
//  MatchResultEditViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/7/21.
//

import UIKit
import FirebaseDatabase

class MatchResultEditViewController: UIViewController {
    
    // MARK: - Properties
    typealias InputDataType = MatchResult
    enum EditMode {
        case new
        case edit(InputDataType)
    }
    
    private var viewModel: MatchResultEditViewModel
    private var tableBase = TableViewBase()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.EditEventLabel.wantDelete,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: L10n.EditEventLabel.deleteTypeTitle, style: .destructive) { _ in
            self.viewModel.event.delete { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
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
        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = false
        view.register(MatchResultEditCell.self, forCellReuseIdentifier: MatchResultEditViewConfigurator.reuseIdentifier)
        view.register(SaveTableCell.self, forCellReuseIdentifier: SaveViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        view.separatorStyle = .none
        return view
    }()
    
    private var keyboardManager = KeyboardAppearanceManager()
        
    // MARK: - Init
    
    init(editMode: EditMode) {
        var isNew = false
        switch editMode {
        case .new:
            viewModel = MatchResultEditViewModel(event: MatchResultImpl())
            isNew = true
        case .edit(let data):
            viewModel = MatchResultEditViewModel(event: data)
        }
        super.init(nibName: nil, bundle: nil)
        title = isNew ? L10n.EditEventLabel.newMatchNavigationBarTitle : L10n.EditEventLabel.existingMatchNavigationBarTitle
        
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
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        if !viewModel.event.isNew {
            let itemDelete = UIBarButtonItem(title: L10n.Other.delete, style: .plain, target: self, action: #selector(handleDelete))
            navigationItem.rightBarButtonItem = itemDelete
        }
    }
    
    private func configureViewModel() {
        tableBase.setupTable(tableView)
        let dataSource = createDataSource()
        tableBase.updateDataSource(dataSource)
    }
    
}

extension MatchResultEditViewController {
    
    func createDataSource() -> TableDataSource {
        var sections: [TableSection] = []
        var section = TableSection()
        let eventEditRow = makeEventEditTableRow(),
            saveRow = makeSaveTableRow()
        section.addRows([eventEditRow, saveRow])
        sections.append(section)
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeEventEditTableRow() -> TableRow {
        var cellModel = MatchResultEditCellModel(data: viewModel.event)
        cellModel.setTitleAction = { (text: String) in
            self.viewModel.event.title = text
        }
        cellModel.setHomeTeamAction = { (text: String) in
            self.viewModel.event.homeTeam = text
        }
        cellModel.setAwayTeamAction = { (text: String) in
            self.viewModel.event.awayTeam = text
        }
        cellModel.setHomeTeamScoreAction = { (score: Int) in
            self.viewModel.event.homeTeamScore = score
        }
        cellModel.setAwayTeamScoreAction = { (score: Int) in
            self.viewModel.event.awayTeamScore = score
        }
        cellModel.setStadiumAction = { (text: String) in
            self.viewModel.event.stadium = text
        }
        cellModel.setDateAction = { (date: Date) in
            self.viewModel.event.date = date
        }
        let config = MatchResultEditViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeSaveTableRow() -> TableRow {
        var cellModel = SaveCellModel()
        cellModel.action = {
            self.viewModel.save { error in
                if let error = error {
                    assertionFailure(error.errorDescription ?? "")
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        let config = SaveViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    @objc private func handleDelete() {
        present(alert, animated: true)
    }
    
}
