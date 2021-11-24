//
//  SquadDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 10/28/21.
//

import UIKit

class SquadDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    typealias InputDataType = Squad
    private lazy var viewModel: SquadDetailViewModel = {
        return SquadDetailViewModel(delegate: self)
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: ClubManager.shared.current)
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
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        PlayerCellConfigurator.registerCell(tableView: view)
        view.tableFooterView = tableFooterView
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
        configureViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
        title = viewModel.filter?.displayName ?? ""
        let itemReport = UIBarButtonItem(title: "Report", style: .plain, target: self, action: #selector(reportHandle))
        let itemEdit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editHandle))
        navigationItem.rightBarButtonItems = [itemReport, itemEdit]
    }
    
    private func configureViewModel() {
    }
}

extension SquadDetailViewController: UITableViewDelegate {
       
}

extension SquadDetailViewController: InputData {
    
    func setInputData(_ inputData: InputDataType) {
        viewModel.filter = inputData
    }
    
}

extension SquadDetailViewController: CellUpdatable {
    
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

extension SquadDetailViewController {
    
    @objc func reportHandle() {
        
    }
    
    @objc func editHandle() {
//        guard let dataSource = viewModel.dataSource else {
//            return
//        }
//        let vc = EditEventViewController(editMode: .edit(dataSource))
//        vc.modalPresentationStyle = .pageSheet
//        vc.modalTransitionStyle = .crossDissolve
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
