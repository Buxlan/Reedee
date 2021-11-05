//
//  ProfileViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = ProfileViewModel()
    
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
        NewsCellConfigurator.registerCell(tableView: view)
        MatchResultCellConfigurator.registerCell(tableView: view)
        ActionCellConfigurator.registerCell(tableView: view)
        return view
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tableFooterView: UIView = {
        let view = UIView()
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
        title = L10n.News.navigationBarTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureViewModel() {
        viewModel.populateCellRelay = { (_, indexPath, snap) -> UITableViewCell in
            guard let event = SportEventCreatorImpl().create(snapshot: snap) else {
                return UITableViewCell()
            }
            var row: TableRow<SportEvent>
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
extension ProfileViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController {
    
    @objc private func addEventHandle() {
        let vc = EditEventViewController(editMode: .new)
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createDataSource() {
        
    }
    
    func makeNewsTableRow(_ event: SportEvent) -> TableRow<SportEvent> {
        guard let event = event as? SportNews else {
            fatalError()
        }
        let cellModel = NewsTableCellModel(data: event)
        let configurator = NewsCellConfigurator(data: cellModel)
        let row = TableRow(config: configurator, data: event as SportEvent)
        return row
    }
    
    func makeMatchResultTableRow(_ event: SportEvent) -> TableRow<SportEvent> {
        guard let event = event as? MatchResult else {
            fatalError()
        }
        let cellModel = MatchResultTableCellModel(data: event)
        let configurator = MatchResultCellConfigurator(data: cellModel)
        let row = TableRow(config: configurator, data: event as SportEvent)
        return row
    }
    
}
