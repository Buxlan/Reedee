//
//  EditEventViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

class EditEventViewController: UIViewController {
    
    // MARK: - Properties
    
    enum EditMode {
        case new
        case edit(DataType)
    }
    
    typealias DataType = SportEvent
    var data: DataType
    
    private lazy var viewModel: EditEventViewModel = {
        return EditEventViewModel(delegate: self)
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
        view.register(EditEventTitleCell.self,
                      forCellReuseIdentifier: EditEventTitleCell.reuseIdentifier)

        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
            
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        data = DataType()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    init(editMode: EditMode) {
        switch editMode {
        case .new:
            data = DataType()
        case .edit(let data):
            self.data = data
        }
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        data = DataType()
        super.init(coder: coder)
        configureTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureRecognizers()
        configureViewModel()
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
        viewModel.dataSource = data
    }
    
    private func configureRecognizers() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
}

extension EditEventViewController: UITableViewDelegate {
       
}

extension  EditEventViewController {
    @objc
    private func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditEventViewController: CellUpdatable {
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
