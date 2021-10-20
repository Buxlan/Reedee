//
//  LastNewsTableViewController.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit
import FirebaseDatabase

protocol CellUpdatable: class {
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell
    func reloadData()
}

extension CellUpdatable {
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell {
        return UITableViewCell()
    }
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        return UITableViewCell()
    }
    func reloadData() {        
    }
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = HomeViewModel()
    var actionProxy: CellActionProxy = .init()
    var team = SportTeam.current
    
//    private lazy var addEventButton: UIButton = {
//        let view = UIButton()
//        view.accessibilityIdentifier = "addEventButton"
//        view.backgroundColor = Asset.accent1.color
//        view.tintColor = Asset.other0.color
//        view.addTarget(self, action: #selector(addEventHandle), for: .touchUpInside)
//        let image = Asset.plus.image.withRenderingMode(.alwaysTemplate)
//        view.setImage(image, for: .normal)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 16
//        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
//
//        return view
//    }()
    
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
//        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
//        view.estimatedRowHeight = 60
        view.register(ActionsTableCell.self,
                      forCellReuseIdentifier: ActionsTableCell.reuseIdentifier)
        view.register(EventTableCell.self,
                      forCellReuseIdentifier: EventTableCell.reuseIdentifier)
        view.register(ComingEventTableCell.self,
                      forCellReuseIdentifier: ComingEventTableCell.reuseIdentifier)
        view.register(PhotoGalleryTableCell.self,
                      forCellReuseIdentifier: ComingEventTableCell.reuseIdentifier)
        
        view.register(EventsSectionHeaderView.self,
                      forCellReuseIdentifier: EventsSectionHeaderView.reuseIdentifier)
        view.register(ComingEventsSectionHeaderView.self,
                      forCellReuseIdentifier: ComingEventsSectionHeaderView.reuseIdentifier)

        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: team)
        return view
    }()
        
    // MARK: - Init
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
//        setupActionHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
        configureViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let image = Asset.home.image.resizeImage(to: 24,
                                                 aspectRatio: .current,
                                                 with: view.tintColor)
        tabBarItem.image = image
        viewModel.dataSource?.unbind()
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.backgroundColor = Asset.accent1.color
        view.addSubview(tableView)
//        view.addSubview(addEventButton)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            
//            addEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            addEventButton.widthAnchor.constraint(equalToConstant: 44),
//            addEventButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
//            addEventButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.Squads.tabBarItemTitle
        let image = Asset.homeFill.image.resizeImage(to: 24,
                                                    aspectRatio: .current,
                                                    with: view.tintColor)
        tabBarItem.image = image
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.News.navigationBarTitle
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationItem.backBarButtonItem?.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = Asset.accent1.color
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Asset.other3.color
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = titleTextAttributes
        let image = Asset.plus.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(addEventHandle))
//        item.imageInsets = .init(top: 0, left: 8, bottom: 8, right: 8)
        item.tintColor = .white
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.dataSource?.bind(to: tableView)
    }
    
//    private func setupActionHandlers() {
//        actionProxy.on(.didSelect) { (config: CommandTableCellConfigurator, _) in
//            print("CommandTableCellConfigurator \(config)")
//        }.on(.didSelect) { [weak self] (event: SportEvent, _) in
//            guard let self = self else {
//                return
//            }
//            let vc = EventDetailViewController()
//            vc.data = config.data
//            vc.modalTransitionStyle = .crossDissolve
//            self.navigationController?.pushViewController(vc, animated: true)
//        }.on(.didSelect) { [weak self] (config: ComingEventCellConfigurator, _) in
//            guard let self = self else {
//                return
//            }
//            let vc = EventDetailViewController()
//            vc.data = config.data
//            vc.modalTransitionStyle = .crossDissolve
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.item(at: indexPath)
        let vc = EventDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.inputData = event
        present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let view = collectionView as? Typeable else {
//            fatalError("collectioh view doesn't conform to Typeable")
//        }
//        let items = viewModel.sections[view.type] ?? [CellConfigurator]()
//        return items.count
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let view = collectionView as? Typeable else {
//            fatalError("Collection view doesn't conform to Typeable")
//        }
//        let items = viewModel.sections[view.type] ?? [CellConfigurator]()
//        let item = items[indexPath.item]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseIdentifier,
//                                                      for: indexPath)
//        item.configure(cell: cell)
//        return cell
        return UICollectionViewCell()
    }
    
}

extension HomeViewController {
    @objc
    private func addEventHandle() {
        let vc = EditEventViewController(editMode: .new)
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
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
