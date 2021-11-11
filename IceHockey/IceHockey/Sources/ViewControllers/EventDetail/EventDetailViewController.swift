//
//  EventDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    typealias InputDataType = SportNews
    private lazy var viewModel: EventDetailViewModel = {
        return EventDetailViewModel(delegate: self)
    }()
    var actionProxy: CellActionProxy = .init()
    private var swipeDirection: UISwipeGestureRecognizer.Direction?
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
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
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Other.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: L10n.Other.edit, style: .destructive) { _ in
            guard let dataSource = self.viewModel.dataSource else {
                return
            }
            let vc = EditEventViewController(editMode: .edit(dataSource))
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let reportAction = UIAlertAction(title: L10n.Other.report, style: .destructive) { _ in
            // report
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
            
    // MARK: - Init
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
        configureRecognizers()
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
        view.backgroundColor = Asset.accent1.color
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
        let menuItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItem = menuItem
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
    
    func setInputData(_ inputData: SportNews) {
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
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
}
