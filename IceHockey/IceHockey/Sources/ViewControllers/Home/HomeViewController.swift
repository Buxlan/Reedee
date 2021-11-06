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
    var viewModel = HomeViewModel()
    var team = SportTeam.current
    
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
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = viewModel.dataSource
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
        NewsCellConfigurator.registerCell(tableView: view)
        MatchResultCellConfigurator.registerCell(tableView: view)
        ActionCellConfigurator.registerCell(tableView: view)
        return view
    }()
    
    private lazy var tableHeaderView: HomeTableViewHeader = {
        let height = UIScreen.main.bounds.height * 0.15
        let frame = CGRect(x: 0, y: 0, width: 0, height: height)
        let view = HomeTableViewHeader(frame: frame)
        view.dataSource = self
        view.configureUI()
        return view
    }()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: team)
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
        viewModel.dataSource?.unbind()
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
            appendEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            appendEventButton.widthAnchor.constraint(equalToConstant: 44),
            appendEventButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            appendEventButton.heightAnchor.constraint(equalToConstant: 44)
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
        configureModeratorFunctions()
        viewModel.populateCellRelay = { (_, indexPath, snap) -> UITableViewCell in
            guard let event = SportEventCreatorImpl().create(snapshot: snap) else {
                return UITableViewCell()
            }
            var row: OldTableRow<SportEvent>
            switch event.type {
            case .event:
                row = self.makeNewsTableRow(event)
                self.viewModel.items[indexPath] = row
            case .match:
                row = self.makeMatchResultTableRow(event)
                self.viewModel.items[indexPath] = row
            default:
                fatalError()
            }
            let cell = self.tableView.dequeueReusableCell(withIdentifier: type(of: row.config).reuseIdentifier, for: indexPath)
            row.config.configure(cell: cell)
            return cell
        }
        viewModel.dataSource?.bind(to: tableView)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.item(at: indexPath)
        switch event.type {
        case .event:
            guard let event = event as? SportNews else { fatalError() }
            let vc = EventDetailViewController()
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            vc.setInputData(event)
            navigationController?.pushViewController(vc, animated: true)
        case .match:
            tableView.deselectRow(at: indexPath, animated: true)
            return
//            guard let event = event as? MatchResult else { fatalError() }
//            let vc = MatchResultDetailViewController()
//            vc.modalPresentationStyle = .pageSheet
//            vc.modalTransitionStyle = .crossDissolve
//            vc.setInputData(event)
//            navigationController?.pushViewController(vc, animated: true)
        default:
            fatalError()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.actionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.action(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseIdentifier,
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
        viewModel.dataSource?.unbind()
        viewModel = HomeViewModel()
        configureViewModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func makeNewsTableRow(_ event: SportEvent) -> OldTableRow<SportEvent> {
        guard let event = event as? SportNews else {
            fatalError()
        }
        let cellModel = NewsTableCellModel(data: event)
        let configurator = NewsCellConfigurator(data: cellModel)
        let row = OldTableRow(config: configurator, data: event as SportEvent)
        return row
    }
    
    func makeMatchResultTableRow(_ event: SportEvent) -> OldTableRow<SportEvent> {
        guard let event = event as? MatchResult else {
            fatalError()
        }
        let cellModel = MatchResultTableCellModel(data: event)
        let configurator = MatchResultCellConfigurator(data: cellModel)
        let row = OldTableRow(config: configurator, data: event as SportEvent)
        return row
    }
    
    func configureModeratorFunctions() {
        
        appendEventButton.isHidden = true
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        FirebaseManager.shared.databaseManager
            .root
            .child("moderators")
            .child(uid).getData { error, snapshot in
                guard error == nil,
                      !(snapshot.value is NSNull),
                      let value = snapshot.value as? Bool,
                      value == true else {
                          return
                      }
                self.appendEventButton.isHidden = false
            }
        
    }
    
    @objc private func handleAppendEvent() {
        present(alert, animated: true)
    }
    
}
