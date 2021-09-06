//
//  HockeyTeamDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

class HockeySquadDetailViewController: UIViewController {

    // MARK: - Properties
    var squad: HockeySquad? {
        didSet {
            viewModel.squad = squad
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var viewModel = HockeySquadDetailViewModel()
    
    private lazy var titleView: UIView = {
        let image = Asset.squadLogo.image
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.rowHeight = UITableView.automaticDimension
//        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = 60
        view.estimatedRowHeight = 60
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: "cell")
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        
        view.tableHeaderView = titleView
        view.tableFooterView = UIView()
        return view
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
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }
    
    // MARK: - Hepler functions
    private func configureUI() {
        view.addSubview(tableView)
        navigationController?.navigationItem.titleView = titleView
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
        tabBarItem.title = L10n.Squads.tabBarItemTitle
        let image = Asset.shoppingCart.image.resizeImage(to: 24,
                                                    aspectRatio: .current,
                                                    with: view.tintColor)
        tabBarItem.image = image
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = squad?.name ?? "?"
//        navigationController?.navigationItem.titleView = titleView
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem?.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HockeySquadDetailViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        let vc = HockeyPlayerDetailViewController()
        vc.staff = item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
   
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = viewModel.sections[section]
        return section.role.description
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.item(at: indexPath)
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        configure(cell: cell, item: item)
        
        return cell
    }
    
    private func configure(cell: UITableViewCell, item: HockeyPlayer) {
        cell.textLabel?.text = "#\(item.gameNumber) \(item.displayName)"
        cell.accessoryType = .disclosureIndicator
    }
}
