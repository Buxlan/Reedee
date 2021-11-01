//
//  LastNewsTableViewController.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = HomeViewModel()
    var team = SportTeam.current
    
    private let refreshControl = UIRefreshControl()
    
    private lazy var appendEventImage: UIImage = {
        Asset.plus.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
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
        view.register(EventTableCell.self,
                      forCellReuseIdentifier: EventTableCell.reuseIdentifier)
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
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)            
//            addEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            addEventButton.widthAnchor.constraint(equalToConstant: 44),
//            addEventButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
//            addEventButton.heightAnchor.constraint(equalToConstant: 44)
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
        viewModel.delegate = self
        viewModel.dataSource?.bind(to: tableView)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.item(at: indexPath)
        let vc = EventDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        vc.setInputData(event)
        navigationController?.pushViewController(vc, animated: true)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refreshControl.endRefreshing()
        }
    }
    
}

extension HomeViewController: CellUpdatable {
    
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: event.type.identifier,
                                                 for: indexPath)
        if let cell = cell as? ConfigurableEventCell {
            cell.configure(with: event)
        }
        return cell
    }
    
}
