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
    enum EditMode: CustomStringConvertible, Equatable {
        case new
        case edit(InputDataType)
        
        var description: String {
            switch self {
            case .new:
                return "new"
            case .edit(_):
                return "existing"
            }
        }
        
        static func == (lhs: MatchResultEditViewController.EditMode, rhs: MatchResultEditViewController.EditMode) -> Bool {
            lhs.description == rhs.description
        }
    }
    private var editingObject: InputDataType
    
    var viewModel = TableViewBase()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.EditEventLabel.wantDelete,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: L10n.EditEventLabel.deleteTypeTitle, style: .destructive) { _ in
            do {
                try MatchResultFirebaseRemover(object: self.editingObject).remove()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                print(error)
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
        switch editMode {
        case .new:
            editingObject = MatchResultImpl()
        case .edit(let data):
            editingObject = data
        }
        super.init(nibName: nil, bundle: nil)
        title = (editMode == .new) ? L10n.EditEventLabel.newMatchNavigationBarTitle : L10n.EditEventLabel.existingMatchNavigationBarTitle
        
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
        if !editingObject.isNew {
            let itemDelete = UIBarButtonItem(title: L10n.Other.delete, style: .plain, target: self, action: #selector(handleDelete))
            navigationItem.rightBarButtonItem = itemDelete
        }
    }
    
    private func configureViewModel() {
        viewModel.setupTable(tableView)
        let dataSource = createDataSource()
        viewModel.updateDataSource(dataSource)
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
        var cellModel = MatchResultEditCellModel(data: editingObject)
        cellModel.setTitleAction = { (text: String) in
            self.editingObject.title = text
        }
        cellModel.setHomeTeamAction = { (text: String) in
            self.editingObject.homeTeam = text
        }
        cellModel.setAwayTeamAction = { (text: String) in
            self.editingObject.awayTeam = text
        }
        cellModel.setHomeTeamScoreAction = { (score: Int) in
            self.editingObject.homeTeamScore = score
        }
        cellModel.setAwayTeamScoreAction = { (score: Int) in
            self.editingObject.awayTeamScore = score
        }
        cellModel.setStadiumAction = { (text: String) in
            self.editingObject.stadium = text
        }
        cellModel.setDateAction = { (date: Date) in
            self.editingObject.date = date
        }
        let config = MatchResultEditViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config, height: UITableView.automaticDimension)
        return row
    }    
    
    func makeSaveTableRow() -> TableRow {
        var cellModel = SaveCellModel()
        cellModel.action = {
            MatchResultFirebaseSaver(object: self.editingObject)
                .save { error in
                
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        let config = SaveViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier,
                           config: config)
        return row
    }
    
    @objc private func handleDelete() {
        present(alert, animated: true)
    }
    
}
