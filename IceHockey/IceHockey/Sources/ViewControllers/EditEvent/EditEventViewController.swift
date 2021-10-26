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
    
    private lazy var handler: EditEventHandler = {
        EditEventHandler(delegate: self)
    }()
    private lazy var viewModel: EditEventViewModel = {
        let viewModel = EditEventViewModel(handler: handler)
        viewModel.delegate = self
        return viewModel
    }()
    private var keyboardManager = KeyboardAppearanceManager()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
    private var imagePicker = UIImagePickerController()
    private var pickerManager = ImagePickerManager()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = viewModel
        view.backgroundColor = Asset.other2.color
        view.allowsSelection = false
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 300
        view.rowHeight = UITableView.automaticDimension
        
        EditEventTitleCellConfigurator.registerCell(tableView: view)
        EditEventTitleTextFieldCellConfigurator.registerCell(tableView: view)
        EditEventTextCellConfigurator.registerCell(tableView: view)
        EditEventBoldTextCellConfigurator.registerCell(tableView: view)
        EditEventSaveCellConfigurator.registerCell(tableView: view)
        EditEventAddPhotoCellConfigurator.registerCell(tableView: view)
        EditEventInputDateCellConfigurator.registerCell(tableView: view)

        view.tableFooterView = UIView()
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
            
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    init(editMode: EditMode) {
        super.init(nibName: nil, bundle: nil)
        switch editMode {
        case .new:
            viewModel.dataSource = DataType()
        case .edit(let data):
            viewModel.dataSource = data
        }
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
//        setupActionHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBars()
        keyboardManager.register(scrollView: tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let image = Asset.home.image.resizeImage(to: 24,
                                                 aspectRatio: .current,
                                                 with: view.tintColor)
        tabBarItem.image = image
        keyboardManager.unregister()
    }
    
    // MARK: - Hepler functions
    
    private func configureUI() {
        tableView.backgroundColor = Asset.other1.color
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
    }
    
}

extension EditEventViewController: InputData {
    func setInputData(_ inputData: DataType) {
        viewModel.dataSource = inputData
    }
}

extension EditEventViewController: UITableViewDelegate {
       
}

extension EditEventViewController: EditEventHandlerInterface {
    
    // MARK: - CellUpdatable
    
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        let reuseId = type(of: configurator).reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId,
                                                 for: indexPath)
        configurator.configure(cell: cell)
        return cell
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - MediaPickerDelegate
    
    func makePhoto() {
        pickerManager.openCamera(self) { image in
            if let image = image {
                self.viewModel.appendImage(image)
            }
        }
    }
    
    func openGallery() {
        pickerManager.openGallery(self) { image in
            if let image = image {
                self.viewModel.appendImage(image)
            }
        }
    }
    
    func save() {
        viewModel.save()
    }
    
    func setDate(_ value: Date) {
        viewModel.setDate(value)
    }
    
    func setTitle(_ value: String) {
        viewModel.setTitle(value)
    }
    
    func setText(_ value: String) {
        viewModel.setText(value)
    }
    
    func setBoldText(_ value: String) {
        viewModel.setBoldText(value)
    }
    
    func appendImage(_ image: UIImage) {
        viewModel.appendImage(image)
    }
    
    func removeImage(withName imageName: String) {
        viewModel.removeImage(withName: imageName)
    }
    
}

extension EditEventViewController: ViewControllerDismissable {
    
    func dismiss(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
}
