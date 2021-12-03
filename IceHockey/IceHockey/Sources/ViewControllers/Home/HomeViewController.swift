//
//  LastNewsTableViewController.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var tableBase = TableViewBase()
    var viewModel = HomeViewModel()
    var club = ClubManager.shared.current
    
    private let refreshControl = UIRefreshControl()
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Events.selectTypeTitle,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let newsAction = UIAlertAction(title: L10n.Events.selectNewEventTitle, style: .default) { _ in
            let vc = EditEventViewController(editMode: .new)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let matchResultAction = UIAlertAction(title: L10n.Events.selectNewMatchResult, style: .default) { _ in
            let vc = MatchResultEditViewController(editMode: .new)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(newsAction)
        controller.addAction(matchResultAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
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
        view.addTarget(self, action: #selector(handleAppendEvent), for: .touchUpInside)
        view.setImage(appendEventImage, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.accent1.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = tableHeaderView
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        view.refreshControl = refreshControl
        view.register(NewsTableCell.self, forCellReuseIdentifier: NewsViewConfigurator.reuseIdentifier)
        view.register(MatchResultTableCell.self, forCellReuseIdentifier: MatchResultViewConfigurator.reuseIdentifier)
        ActionCellConfigurator.registerCell(tableView: view)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 8
        }
        return view
    }()
    
    private lazy var tableHeaderView: HomeTableViewHeader = {
        let height = UIScreen.main.bounds.height * 0.10
        let frame = CGRect(x: 0, y: 0, width: 0, height: height)
        let view = HomeTableViewHeader(frame: frame)
        view.dataSource = self
        view.configureUI()
        return view
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: club)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.addSubview(tableView)
        view.addSubview(appendEventButton)
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            appendEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            appendEventButton.widthAnchor.constraint(equalToConstant: 44),
            appendEventButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.News.navigationBarTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureViewModel() {
        tableBase.setupTable(tableView)
        viewModel.shouldTableRefreshRelay = { [weak self] in
            guard let self = self else { return }
            self.viewModel.dataSource = self.createDataSource()
            self.tableBase.updateDataSource(self.viewModel.dataSource)
            self.tableView.reloadData()
            if !self.viewModel.isLoading {
                self.refreshControl.endRefreshing()
            }
        }
        viewModel.shouldClubRefreshRelay = { [weak self] in
            guard let self = self else { return }
            self.tableFooterView.configure(with: self.viewModel.club)
        }
        viewModel.setRightsEventAdditionRelay = { [weak self] (role) in
            self?.appendEventButton.isHidden = (role == .readOnly)
        }
        viewModel.update()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.action(at: indexPath)
        let reuseIdentifier = type(of: item).reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
}

extension HomeViewController {
    
    @objc private func addEventHandle() {
        let vc = EditEventViewController(editMode: .new)
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func refreshTable(_ sender: Any) {
        refreshControl.beginRefreshing()
        viewModel.update()
    }
    
    func createDataSource() -> TableDataSource {        
        var sections: [TableSection] = []
        viewModel.sections.forEach { sectionData in
            var section = TableSection()
            let rows = sectionData.events.map { event -> TableRow in
                self.makeTableRow(event: event)
            }
            section.addRows(rows)
            sections.append(section)
        }
        
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeTableRow(event: SportEvent) -> TableRow {
        var row: TableRow
        switch event.type {
        case .event:
            row = self.makeNewsTableRow(event)
        case .match:
            row = self.makeMatchResultTableRow(event)
        }
        return row
    }
    
    func makeNewsTableRow(_ event: SportEvent) -> TableRow {
        guard let event = event as? SportNews else {
            fatalError()
        }
        var cellModel = NewsTableCellModel(data: event)
        cellModel.likeAction = { (state: Bool) in
            LikeManager().setLike(for: event.objectIdentifier, newState: state)
        }
        let config = NewsViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config)
        row.action = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: false)
            let object = self.viewModel.sections[indexPath.section].events[indexPath.row]
            if object.isLoading {
                return
            }
            let vc = EventDetailViewController(event)
            vc.modalTransitionStyle = .crossDissolve            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        row.willDisplay = { [weak self] _, indexPath in
            guard let self = self else { return }
            let lastIndexPath = self.viewModel.dataSource.lastIndexPath
            if indexPath == lastIndexPath {
                self.viewModel.updateNextPortion()
            }
        }
        return row
    }
    
    func makeMatchResultTableRow(_ event: SportEvent) -> TableRow {
        guard let event = event as? MatchResult else {
            assertionFailure()
            return TableRow(rowId: "")
        }
        var cellModel = MatchResultTableCellModel(data: event)
        cellModel.likeAction = { (state: Bool) in
            LikeManager().setLike(for: event.objectIdentifier, newState: state)
        }
        let config = MatchResultViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config)
        row.action = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            let object = self.viewModel.sections[indexPath.section].events[indexPath.row]
            if object.isLoading {
                return
            }
            let vc = MatchResultDetailViewController(editMode: .edit(event))
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        row.willDisplay = { [weak self] _, indexPath in
            guard let self = self else { return }
            let lastIndexPath = self.viewModel.dataSource.lastIndexPath
            if indexPath == lastIndexPath {
                self.viewModel.updateNextPortion()
            }
        }
        return row
    }
    
    @objc private func handleAppendEvent() {
        present(alert, animated: true)
    }
    
}
