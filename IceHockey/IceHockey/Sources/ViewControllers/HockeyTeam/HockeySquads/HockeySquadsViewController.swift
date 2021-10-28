//
//  HockeySquadsViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

class HockeySquadsViewController: UIViewController {

    // MARK: - Properties
    let viewModel = HockeySquadViewModel()
    
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
        
        view.tableHeaderView = UIView()
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
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
        title = L10n.Squads.title
        tabBarItem.title = L10n.Squads.tabBarItemTitle
        let image = Asset.person3.image.resizeImage(to: 24,
                                                    aspectRatio: .current,
                                                    with: view.tintColor)
        tabBarItem.image = image        
    }
    
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HockeySquadsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.item(at: indexPath)
        let vc = HockeySquadDetailViewController()
        vc.squad = item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
   
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        configure(cell: cell, item: item)
        
        return cell
    }
    
    private func configure(cell: UITableViewCell, item: SportSquad) {
        cell.textLabel?.text = item.name
        cell.accessoryType = .disclosureIndicator
    }
}
