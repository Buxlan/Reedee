//
//  OurSquadsViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/01/21.
//

import UIKit
import FirebaseDatabase

class TrainingScheduleViewController: UIViewController {
    
    // MARK: - Properties
    typealias InputDataType = SportTeam
    var viewModel: TrainingScheduleViewModel = TrainingScheduleViewModel()
    private var tableBase = TableViewBase()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.other3.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = true
        
//        view.insetsContentViewsToSafeArea = false
//        view.insetsLayoutMarginsFromSafeArea = false
//        view.layoutMargins = .zero
//        view.contentInset = .zero
        view.sectionFooterHeight = 0.0
        view.sectionHeaderHeight = 60.0
        view.estimatedSectionHeaderHeight = 60.0
        view.estimatedSectionFooterHeight = 60.0
        
        view.register(TrainingCell.self, forCellReuseIdentifier: TrainingViewConfigurator.reuseIdentifier)
        view.register(SquadHeaderView.self, forHeaderFooterViewReuseIdentifier: SquadViewConfigurator.reuseIdentifier)
        return view
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
        
    // MARK: - Init
    
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
        title = L10n.Squads.trainingTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let itemReport = UIBarButtonItem(title: L10n.Other.report, style: .plain, target: self, action: #selector(handleReport))
        let itemEdit = UIBarButtonItem(title: L10n.Other.edit, style: .plain, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItems = [itemReport, itemEdit]
    }
    
    private func configureViewModel() {
        tableBase.setupTable(tableView)
        viewModel.shouldRefreshRelay = {
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
        viewModel.update()
    }
    
}

extension TrainingScheduleViewController {
    
    func createDataSource() -> TableDataSource {
        
        var sections: [TableSection] = []
        viewModel.sections.forEach { sectionData in
            let cellModel = SquadHeaderCellModel(uid: sectionData.squad.uid, title: sectionData.squad.displayName)
            let config = SquadViewConfigurator(data: cellModel)
            var section = TableSection()
            section.headerConfig = config
            section.headerHeight = 60.0
            section.headerViewId = type(of: config).reuseIdentifier
            let rows = sectionData.schedule.trainings.map { training -> TableRow in
                makeTrainingTableRow(training)
            }
            section.addRows(rows)
            sections.append(section)
        }
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeTrainingTableRow(_ object: DailyTraining) -> TableRow {
        let cellModel = TrainingCellModel(data: object)
        let config = TrainingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    @objc private func handleReport() {
        
    }
    
    @objc private func handleEdit() {
        
    }
    
}
