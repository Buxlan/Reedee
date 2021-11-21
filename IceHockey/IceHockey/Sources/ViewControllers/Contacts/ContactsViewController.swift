//
//  ContactsViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var viewModel: ContactsViewModel = {
        ContactsViewModel(delegate: self)
    }()
    
    private lazy var callUsButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "callUsButton"
        view.backgroundColor = Asset.accent1.color
        view.tintColor = Asset.other3.color
        view.addTarget(self, action: #selector(handleCallUs), for: .touchUpInside)
        let image = Asset.contacts.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 16)
        view.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        view.titleLabel?.font = .boldFont17
        view.setTitle(L10n.Contacts.toCallUsTitle, for: .normal)
        return view
    }()
    
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
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = false
        SquadCellConfigurator.registerCell(tableView: view)
        MapCellConfigurator.registerCell(tableView: view)
        TeamDetailInfoCellConfigurator.registerCell(tableView: view)
        view.register(SimpleSectionTableHeaderView.self, forHeaderFooterViewReuseIdentifier: SimpleSectionTableHeaderView.reuseIdentifier)
        return view
    }()
        
    // MARK: - Lifecircle
    
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
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.backgroundColor = Asset.accent1.color
        view.addSubview(tableView)
        view.addSubview(callUsButton)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            callUsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            callUsButton.widthAnchor.constraint(equalToConstant: 44),
            callUsButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32),
            callUsButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
    }
    
    private func configureBars() {
        title = L10n.Contacts.title
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.update()
    }
    
}

// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { return }
        guard let item = viewModel.config(at: indexPath) as? SquadCellConfigurator else { return }
        let data = item.data
        let vc = SquadDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .crossDissolve
        vc.setInputData(data)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 { return nil }
        let deleteAction = UITableViewRowAction(style: .normal,
                                                title: "Delete") { (_, indexPath) in
            self.viewModel.deleteItem(at: indexPath)
        }
        deleteAction.backgroundColor = Asset.accent2.color
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let reuseIdentifier = SimpleSectionTableHeaderView.reuseIdentifier
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
                as? SimpleSectionTableHeaderView else {
            return UIView()
        }
        let data = TitleTableHeaderData(title: viewModel.sections[section].title)
        view.configure(with: data)
        return view
    }
    
}

extension ContactsViewController: CellUpdatable {
    
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

extension ContactsViewController {
    
    @objc private func handleCallUs() {
        
    }
    
}
