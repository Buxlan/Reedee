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
    private var viewModel: EditEventViewModel
    private var tableBase = TableViewBase()
    private var collectionBase = CollectionViewBase()
    private lazy var imagePicker = ImagePickerManagerChoosableMode()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.backgroundColor = Asset.other1.color
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = true
        view.separatorStyle = .none
        view.register(EventDetailUserView.self, forCellReuseIdentifier: EventDetailUserViewConfigurator.reuseIdentifier)
        view.register(EditEventDateCell.self, forCellReuseIdentifier: EditEventInputDateViewConfigurator.reuseIdentifier)
        view.register(EditEventTitleCell.self, forCellReuseIdentifier: EditEventTitleViewConfigurator.reuseIdentifier)
        view.register(EditEventDescriptionCell.self, forCellReuseIdentifier: EditEventDescriptionViewConfigurator.reuseIdentifier)
        view.register(EditEventBoldTextCell.self, forCellReuseIdentifier: EditEventBoldTextViewConfigurator.reuseIdentifier)
        view.register(EditEventSaveCell.self, forCellReuseIdentifier: SaveViewConfigurator.reuseIdentifier)
        view.register(EditEventPhotoCell.self, forCellReuseIdentifier: EditEventAddPhotoViewConfigurator.reuseIdentifier)
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = 16
        }
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
        var isNew = false
        switch editMode {
        case .new:
            viewModel = EditEventViewModel(event: SportNewsImpl())
            isNew = true
        case .edit(let data):
            viewModel = EditEventViewModel(event: data)
        }
        super.init(nibName: nil, bundle: nil)
        title = isNew ? L10n.EditEventLabel.newEventTitle : L10n.EditEventLabel.editEventTitle
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
        viewModel.shouldReloadRelay = {
            let dataSource = self.createDataSource()
            self.tableBase.updateDataSource(dataSource)
            self.tableView.reloadData()
        }
    }
    
}

extension EditEventViewController {
    
    func createDataSource() -> TableDataSource {
        let sections = makeTableSections()
        let dataSource = TableDataSource(sections: sections)
        return dataSource
    }
    
    private func makeTableSections() -> [TableSection] {
        return [
            makeTableSectionMainInfo(),
            makeTableSectionAdditionalInfo(),
            makeTableSectionPhotos(),            
            makeTableSectionSave()
        ]
    }
    
    @objc private func handleMenu() {
        present(alert, animated: true)
    }
    
}

// MARK: - Table sections

extension EditEventViewController {
    
    func makeTableSectionMainInfo() -> TableSection {
        var section = TableSection()
        let rows = [
            makeDateTableRow(),
            makeTitleTableRow(),
            makeDescriptionTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionPhotos() -> TableSection {
        var section = TableSection()
        let rows = [
            makePhotoTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionAdditionalInfo() -> TableSection {
        var section = TableSection()
        let rows = [
            makeBoldTextTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
    func makeTableSectionSave() -> TableSection {
        var section = TableSection()
        let rows = [
            makeSaveTableRow()
        ]
        section.addRows(rows)
        return section
    }
    
}

// MARK: - Table rows

extension EditEventViewController {
    
    func makeUserTableRow() -> TableRow {
        let cellModel = EventDetailUserCellModel(viewModel.event)
        let config = EventDetailUserViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        row.height = 48.0
        return row
    }
    
    func makePhotoTableRow() -> TableRow {
        var cellModel = EditEventPhotoCellModel(collectionBase: collectionBase)
        cellModel.collectionBase = collectionBase
        let collectionDataSource = makeCollectionViewDataSource()
        collectionBase.updateDataSource(collectionDataSource)
        let config = EditEventAddPhotoViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeCollectionViewDataSource() -> CollectionDataSource {
        let size = CGSize(width: 240, height: 240)
        let collectionRows = viewModel.unremovedImages.map { imageData -> CollectionRow in
            makePhotoCollectionRow(imageData: imageData, size: size)
        }
        let addPhotoCellModel = PhotoCellModel()
        let config = EditEventPhotoCollectionCellConfigurator(data: addPhotoCellModel)
        let row = CollectionRow(rowId: type(of: config).reuseIdentifier, config: config, size: size)
        row.action = {
            self.imagePicker.pickImage(self) { image in
                self.viewModel.appendImage(image)
            }
        }
        var dataSource = CollectionDataSource()
        var section = CollectionSection()
        section.addRows(collectionRows)
        section.addRow(row)
        dataSource.addSection(section)
        return dataSource
    }
    
    func makePhotoCollectionRow(imageData: ImageData, size: CGSize) -> CollectionRow {
        let image = imageData.image
        var cellModel = PhotoCellModel(image: image)
        cellModel.deleteAction = {
            self.viewModel.removeImage(imageData.imageID)
        }
        let config = EditEventPhotoCollectionCellConfigurator(data: cellModel)
        let row = CollectionRow(rowId: type(of: config).reuseIdentifier, config: config, size: size)
        return row
    }
    
    func makeDateTableRow() -> TableRow {
        let cellModel = DateCellModel(viewModel.event.date)
        let config = EditEventInputDateViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeTitleTableRow() -> TableRow {
        var cellModel = TitleCellModel(text: viewModel.event.title)
        cellModel.valueChanged = { text in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            self.viewModel.event.title = text
        }
        let config = EditEventTitleViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeDescriptionTableRow() -> TableRow {
        var cellModel = TextCellModel(text: viewModel.event.text)
        cellModel.valueChanged = { text in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            self.viewModel.event.text = text
        }
        let config = EditEventDescriptionViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeBoldTextTableRow() -> TableRow {
        var cellModel = TextCellModel(text: viewModel.event.boldText)
        cellModel.font = .bxBody2
        cellModel.valueChanged = { text in
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            self.viewModel.event.boldText = text
        }
        let config = EditEventBoldTextViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
    func makeSaveTableRow() -> TableRow {
        var cellModel = SaveCellModel()
        cellModel.action = {
            self.viewModel.save { error in
                if let error = error {
                    print(String(describing: error))
                }
                self.navigationController?.popViewController(animated: true)
            }            
        }
        let config = SaveViewConfigurator(data: cellModel)
        let row = TableRow(rowId: type(of: config).reuseIdentifier, config: config, height: UITableView.automaticDimension)
        return row
    }
    
}
