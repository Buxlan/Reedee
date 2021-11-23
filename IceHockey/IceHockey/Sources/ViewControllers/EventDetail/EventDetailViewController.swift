//
//  EventDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit
import FirebaseDatabase

class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: EventDetailViewModel = EventDetailViewModel()
    var event: SportNews
    private var tableBase = TableViewBase()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.other3.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = tableFooterView
        view.showsVerticalScrollIndicator = true
        view.register(EventDetailUserView.self, forCellReuseIdentifier: EventDetailUserViewConfigurator.reuseIdentifier)
        view.register(EventDetailPhotoView.self, forCellReuseIdentifier: EventDetailPhotoViewConfigurator.reuseIdentifier)
        view.register(EventDetailTitleView.self, forCellReuseIdentifier: EventDetailTitleViewConfigurator.reuseIdentifier)
        view.register(EventDetailDescriptionView.self, forCellReuseIdentifier: EventDetailDescriptionViewConfigurator.reuseIdentifier)
        view.register(EventDetailBoldTextView.self, forCellReuseIdentifier: EventDetailBoldTextViewConfigurator.reuseIdentifier)
        view.register(EventDetailCopyrightView.self, forCellReuseIdentifier: EventDetailCopyrightViewConfigurator.reuseIdentifier)
        view.register(EventDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: EventDetailHeaderViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: SportTeamManager.shared.current)
        return view
    }()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Other.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: L10n.Other.edit, style: .default) { _ in
            // edit
            let vc = EditEventViewController(editMode: .edit(self.event))
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let reportAction = UIAlertAction(title: L10n.Other.bugReport, style: .destructive) { _ in
            // bug report
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
        
    // MARK: - Lifecircle
    
    init(_ event: SportNews) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
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
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        view.backgroundColor = Asset.accent1.color
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.EventDetail.title
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let menuItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItem = menuItem
    }
    
    private func configureViewModel() {
        let dataSource = self.createDataSource()
        tableBase.updateDataSource(dataSource)
        tableBase.setupTable(tableView)
        viewModel.shouldRefreshRelay = {
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
    }
    
}

extension EventDetailViewController {
    
    func createDataSource() -> TableDataSource {
        
        var sections: [TableSection] = []
        
//        let cellModel = EventDetailHeaderCellModel(title: event.title)
//        let config = EventDetailHeaderViewConfigurator(data: cellModel)
        var section = TableSection()
//        section.headerConfig = config
//        section.headerHeight = 60.0
//        section.headerViewId = type(of: config).reuseIdentifier
        
        let userRow = makeUserTableRow(),
            photoRow = makePhotoTableRow(),
            titleRow = makeTitleTableRow(),
            descriptionRow = makeDescriptionTableRow(),
            boldTextRow = makeBoldTextTableRow()
        
        section.addRows([userRow, photoRow,
                         titleRow, descriptionRow, boldTextRow])
        sections.append(section)
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    func makeUserTableRow() -> TableRow {
        let cellModel = EventDetailUserCellModel(event)
        let config = EventDetailUserViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.height = 48.0
        return row
    }
    
    func makePhotoTableRow() -> TableRow {
        var cellModel = EventDetailPhotoCellModel(event: event)
        cellModel.likeAction = { (state: Bool) in
            LikeManager().setLike(for: self.event.objectIdentifier, newState: state)
        }
        let config = EventDetailPhotoViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
        
    }
    
    func makeTitleTableRow() -> TableRow {
        let cellModel = TitleCellModel(text: event.title)
        let config = EventDetailTitleViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeDescriptionTableRow() -> TableRow {
        let cellModel = TextCellModel(text: event.text)
        let config = EventDetailDescriptionViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeBoldTextTableRow() -> TableRow {
        let cellModel = TextCellModel(text: event.boldText)
        let config = EventDetailBoldTextViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeCopyrightTableRow() -> TableRow {
        let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String ?? ""
        let cellModel = EventDetailCopyrightCellModel(teamID: teamID)
        let config = EventDetailCopyrightViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
}
