//
//  EventDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    typealias InputDataType = SportEvent
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
        view.register(EventDetailUsefulButtonsCell.self,
                      forCellReuseIdentifier: EventDetailUsefulButtonsCell.reuseIdentifier)
        view.register(EventDetailDescriptionCell.self,
                      forCellReuseIdentifier: EventDetailDescriptionCell.reuseIdentifier)
        view.register(EventDetailBoldViewCell.self,
                      forCellReuseIdentifier: EventDetailBoldViewCell.reuseIdentifier)
        view.register(EventDetailTitleCell.self,
                      forCellReuseIdentifier: EventDetailTitleCell.reuseIdentifier)
        view.register(EventDetailCopyrightCell.self,
                      forCellReuseIdentifier: EventDetailCopyrightCell.reuseIdentifier)
                        
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
        let itemReport = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(reportHandle))
        let itemEdit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editHandle))
        navigationItem.rightBarButtonItems = [itemReport, itemEdit]
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

extension EventDetailViewController: InputData {
    
    func setInputData(_ inputData: SportEvent) {
        viewModel.dataSource = inputData
    }
    
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

extension EventDetailViewController {
    
    @objc func reportHandle() {
        
    }
    
    @objc func editHandle() {
        guard let dataSource = viewModel.dataSource else {
            return
        }
        let vc = EditEventViewController(editMode: .edit(dataSource))
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
