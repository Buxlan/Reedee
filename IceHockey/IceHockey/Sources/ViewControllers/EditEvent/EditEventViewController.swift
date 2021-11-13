//
//  EditEventViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit
import FirebaseDatabase

class EditEventViewController: UIViewController {
    
    // MARK: - Properties
    typealias InputDataType = SportNews
    enum EditMode {
        case new
        case edit(InputDataType)
    }
    var event: InputDataType
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
        view.register(EditEventTitleCell.self, forCellReuseIdentifier: EditEventTitleViewConfigurator.reuseIdentifier)
        view.register(EditEventInputDateCell.self, forCellReuseIdentifier: EditEventInputDateViewConfigurator.reuseIdentifier)
        view.register(EditEventInputTitleCell.self, forCellReuseIdentifier: EditEventTitleTextFieldViewConfigurator.reuseIdentifier)
        view.register(EditEventInputTextCell.self, forCellReuseIdentifier: EditEventTextViewConfigurator.reuseIdentifier)
        view.register(EditEventInputBoldTextCell.self, forCellReuseIdentifier: EditEventBoldTextViewConfigurator.reuseIdentifier)
        view.register(EditEventSaveCell.self, forCellReuseIdentifier: EditEventSaveViewConfigurator.reuseIdentifier)
        view.register(EditEventPhotoCell.self, forCellReuseIdentifier: EditEventAddPhotoViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 0
        }
        return view
    }()
    
    private lazy var tableFooterView: EventDetailFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
    
    private lazy var alert: UIAlertController = {
        let controller = UIAlertController(title: L10n.Other.selectAction,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: L10n.Other.bugReport, style: .destructive) { _ in
            // bug report
        }
        let cancelAction = UIAlertAction(title: L10n.Other.cancel, style: .cancel) { _ in
        }
        controller.addAction(deleteAction)
        controller.addAction(cancelAction)
        
        return controller
    }()
    
    private lazy var menuImage: UIImage = {
        let imageHeight: CGFloat = 32.0
        return Asset.menu.image.resizeImage(to: imageHeight, aspectRatio: .current)
        
    }()
        
    // MARK: - Lifecircle
    
    init(editMode: EditMode) {
        switch editMode {
        case .new:
            event = InputDataType()
        case .edit(let data):
            event = data
        }
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
    }
    
}

extension EditEventViewController {
    
    func createDataSource() -> TableDataSource {
        
        var sections: [TableSection] = []
        var section = TableSection()
        
        let userRow = makeUserTableRow(),
            photoRow = makePhotoTableRow(),
            dateRow = makeDateTableRow(),
            titleRow = makeTitleTableRow(),
            descriptionRow = makeDescriptionTableRow(),
            boldTextRow = makeBoldTextTableRow()
        
        section.addRows([userRow, photoRow, dateRow,
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
        let cellModels = event.imageIDs.map { imageID -> EventDetailPhotoCellModel in
            EventDetailPhotoCellModel(imageID: imageID, eventUID: self.event.uid)
        }
        let config = EditEventAddPhotoViewConfigurator(data: cellModels)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeTitleTableRow() -> TableRow {
        let cellModel = EventDetailTitleCellModel(title: event.title)
        let config = EditEventTitleViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeDateTableRow() -> TableRow {
        let cellModel = DateCellModel(event.date)
        let config = EditEventInputDateViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeDescriptionTableRow() -> TableRow {
        let cellModel = EventDetailDescriptionCellModel(title: event.text)
        let config = EditEventTextViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeBoldTextTableRow() -> TableRow {
        let cellModel = EventDetailBoldTextCellModel(title: event.boldText)
        let config = EditEventBoldTextViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeSaveTableRow() -> TableRow {
        let cellModel = SaveCellModel(L10n.Other.save)
        let config = EditEventSaveViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
}
