//
//  OurSquadsViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/01/21.
//

import UIKit
import FirebaseDatabase

class TrainingScheduleViewController: UIViewController, TrainingScheduleViewProtocol {    
    // MARK: - Properties
    
    typealias InputDataType = Club
    
    var onCompletion: CompletionBlock?
    var viewModel: TrainingScheduleViewModel = TrainingScheduleViewModel()
    private var tableBase = TableViewBase()
    var team = ClubManager.shared.current
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.other3.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = tableFooterView
        view.tableHeaderView = nil
        view.showsVerticalScrollIndicator = true
        view.register(TrainingCell.self, forCellReuseIdentifier: TrainingViewConfigurator.reuseIdentifier)
        view.register(SquadHeaderView.self, forHeaderFooterViewReuseIdentifier: SquadHeaderViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: team)
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
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        let menuItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItem = menuItem
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
            let cellModel = SquadHeaderCellModel(uid: sectionData.squad.objectIdentifier,
                                                 title: sectionData.squad.displayName)
            let config = SquadHeaderViewConfigurator(data: cellModel)
            var section = TableSection()
            section.headerConfig = config
            section.headerHeight = 60.0
            section.headerViewId = type(of: config).reuseIdentifier
            let rows = sectionData.schedule.workouts.map { training -> TableRow in
                makeTrainingTableRow(training)
            }
            section.addRows(rows)
            sections.append(section)
        }
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeTrainingTableRow(_ object: DayWorkout) -> TableRow {
        let cellModel = TrainingCellModel(data: object)
        let config = TrainingViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
    @objc private func report() {
        
    }
    
    @objc private func editEvent() {
//        let vc = MatchResultEditViewController(editMode: .edit(self.editingObject))
//        vc.modalTransitionStyle = .crossDissolve
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
