//
//  LastNewsTableViewController.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit

class LastEventsTableViewController: UIViewController, DatableObject {
    
    // MARK: - Properties
    var data: SportTeam? {
        didSet {
            viewModel.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var viewModel = LastEventsViewModel()
    var actionProxy: CellActionProxy = .init()
        
    private lazy var titleView: UIView = {
        let screenWidth = UIScreen.main.bounds.size.width
        let imageHeight = screenWidth * 0.7
        let image = Asset.squad2012.image
            .resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
//        view.autoresizingMask = [.flexibleWidth]
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = Asset.other2.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
//        view.rowHeight = 60
//        view.estimatedRowHeight = 60
        view.register(PinnedEventTableCell.self,
                      forCellReuseIdentifier: PinnedEventTableCell.reuseIdentifier)
        view.register(EventTableCell.self,
                      forCellReuseIdentifier: EventTableCell.reuseIdentifier)
        view.register(ComingEventTableCell.self,
                      forCellReuseIdentifier: ComingEventTableCell.reuseIdentifier)
        
        view.register(EventsSectionHeaderView.self,
                      forHeaderFooterViewReuseIdentifier: EventsSectionHeaderView.reuseIdentifier)
        
        view.register(ComingEventsSectionHeaderView.self,
                      forHeaderFooterViewReuseIdentifier: ComingEventsSectionHeaderView.reuseIdentifier)
                        
//        view.tableHeaderView = titleView
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
        setupActionHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
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
//        navigationController?.navigationItem.titleView = titleView
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
    
    private func setupActionHandlers() {
        actionProxy.on(.didSelect) { [weak self] (config: PinnedEventCellConfigurator, _) in
            guard let self = self else {
                return
            }
            let vc = EventDetailViewController()
            vc.data = config.data
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }.on(.didSelect) { [weak self] (config: EventCellConfigurator, _) in
            guard let self = self else {
                return
            }
            let vc = EventDetailViewController()
            vc.data = config.data
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }.on(.didSelect) { [weak self] (config: ComingEventCellConfigurator, _) in
            guard let self = self else {
                return
            }
            let vc = EventDetailViewController()
            vc.data = config.data
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LastEventsTableViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let config = viewModel.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: config).reuseIdentifier,
                                                 for: indexPath)
        actionProxy.invoke(action: .didSelect, cell: cell, config: config)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let reuseId = section == 1 ? EventsSectionHeaderView.reuseIdentifier : ComingEventsSectionHeaderView.reuseIdentifier
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId)                
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
   
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = viewModel.sections[section].title ?? ""
        if title.isEmpty {
            return 12
        } else {
            return 40
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 220 : 300
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var title = viewModel.sections[section].title ?? ""
//        title = title.isEmpty ? " " : title
//        return title
//    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let config = viewModel.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: config).reuseIdentifier,
                                                for: indexPath)
        if var castedCell = cell as? ContainedCollectionViewCell {
            castedCell.delegate = self
            castedCell.dataSource = self
        }
        config.configure(cell: cell)
        return cell
    }
}

extension LastEventsTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pinnedSection.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.pinnedSection.items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinnedEventCollectionCell.reuseIdentifier, for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
}
