//
//  TeamListViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 10/28/21.
//

import UIKit

class TeamListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = TeamListViewModel()
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var appendNewObjectButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "appendNewObjectButton"
        view.backgroundColor = Asset.accent1.color
        view.tintColor = Asset.other3.color
        view.addTarget(self, action: #selector(handleAppendNewObject), for: .touchUpInside)
        let image = Asset.plus.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        return view
    }()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = viewModel.dataSource
        view.backgroundColor = Asset.other2.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension        
        TeamCellConfigurator.registerCell(tableView: view)
        
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        view.refreshControl = refreshControl
        return view
    }()
        
    // MARK: - Lifecircle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        let image = Asset.person3.image.resizeImage(to: 24,
                                                 aspectRatio: .current,
                                                 with: view.tintColor)
        tabBarItem.image = image
        viewModel.dataSource?.unbind()
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.backgroundColor = Asset.accent1.color
        view.addSubview(tableView)
        view.addSubview(appendNewObjectButton)
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            appendNewObjectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            appendNewObjectButton.widthAnchor.constraint(equalToConstant: 44),
            appendNewObjectButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            appendNewObjectButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
        title = L10n.Squads.listTitle
        tabBarItem.title = L10n.Squads.tabBarItemTitle
        let image = Asset.person3.image.resizeImage(to: 24,
                                                    aspectRatio: .current,
                                                    with: view.tintColor)
        tabBarItem.image = image
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.Team.listTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = Asset.accent1.color
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Asset.other3.color
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.dataSource?.bind(to: tableView)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TeamListViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let snapshot = viewModel.dataSource?.snapshot(at: indexPath.row),
            let object = SportTeam(snapshot: snapshot) else {
            return
        }
        let vc = TeamDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        vc.setInputData(object)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal,
                                                title: "Delete") { (_, indexPath) in
            self.viewModel.deleteItem(at: indexPath)
        }
        deleteAction.backgroundColor = Asset.accent2.color
        return [deleteAction]
    }
    
}

extension TeamListViewController {
    
    @objc private func refreshTable(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func handleAppendNewObject() {
        
    }
    
}

extension TeamListViewController: CellUpdatable {
    
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: configurator).reuseIdentifier,
                                                 for: indexPath)
        configurator.configure(cell: cell)
        return cell
    }
}
