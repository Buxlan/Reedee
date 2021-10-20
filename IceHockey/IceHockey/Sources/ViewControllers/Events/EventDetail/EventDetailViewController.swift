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
    private lazy var viewModel: EventDetailViewModel = {
        return EventDetailViewModel(delegate: self)
    }()
    var actionProxy: CellActionProxy = .init()
    private var swipeDirection: UISwipeGestureRecognizer.Direction?
    
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
        view.register(EventDetailPhotoTableCell.self,
                      forCellReuseIdentifier: EventDetailPhotoTableCell.reuseIdentifier)
        view.register(EventDetailUsefulButtonsTableViewCell.self,
                      forCellReuseIdentifier: EventDetailUsefulButtonsTableViewCell.reuseIdentifier)
        view.register(EventDetailDescriptionTableViewCell.self,
                      forCellReuseIdentifier: EventDetailDescriptionTableViewCell.reuseIdentifier)
        view.register(EventDetailBoldTextTableViewCell.self,
                      forCellReuseIdentifier: EventDetailBoldTextTableViewCell.reuseIdentifier)
        view.register(EventDetailTitleTableViewCell.self,
                      forCellReuseIdentifier: EventDetailTitleTableViewCell.reuseIdentifier)
        view.register(EventDetailCopyrightTableViewCell.self,
                      forCellReuseIdentifier: EventDetailCopyrightTableViewCell.reuseIdentifier)
                        
//        view.tableHeaderView = titleView
        view.tableFooterView = tableFooterView
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
        configureRecognizers()
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
        view.addSubview(tableView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
    }
    
    private func configureBars() {
    }
    
    private func configureViewModel() {        
    }
    
    private func configureRecognizers() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
}

extension EventDetailViewController: UITableViewDelegate {
       
}

extension  EventDetailViewController {
    @objc
    private func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
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
