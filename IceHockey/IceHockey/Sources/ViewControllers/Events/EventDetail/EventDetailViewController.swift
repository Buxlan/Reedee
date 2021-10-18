//
//  EventDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit
import FirebaseDatabase

class EventDetailViewController: UIViewController, InputData {
    
    // MARK: - Properties
    typealias DataType = SportEvent
    var inputData: SportEvent? {
        didSet {
            viewModel.dataSource = inputData
        }
    }
    var viewModel = EventDetailViewModel()
    var actionProxy: CellActionProxy = .init()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = viewModel
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
                        
//        view.tableHeaderView = titleView
        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = false
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
        super.init(coder: coder)
        configureTabBarItem()
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
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {        
    }
    
    private func configureConstraints() {
//        let constraints: [NSLayoutConstraint] = [
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
//        ]
//        NSLayoutConstraint.activate(constraints)
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = Asset.accent1.color
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Asset.other3.color
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
    
    private func configureViewModel() {
    }
}

extension EventDetailViewController: UITableViewDelegate {
       
}

extension EventDetailViewController: CellUpdatable {
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: configurator).reuseIdentifier,
                                                 for: indexPath)
        configurator.configure(cell: cell)
        return cell
    }
    func reloadData() {
        tableView.reloadData()
    }
}
