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
    
    private lazy var handler: EditEventHandler = {
        EditEventHandler(delegate: self)
    }()
    private lazy var viewModel: EditEventViewModel = {
        return EditEventViewModel(handler: handler)
    }()
    private var swipeDirection: UISwipeGestureRecognizer.Direction?
    private var keyboardManager = KeyboardAppearanceManager()
    
    private lazy var tableFooterView: EventDetailTableFooterView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        let view = EventDetailTableFooterView(frame: frame)
        view.configure(with: SportTeam.current)
        return view
    }()
    private var imagePicker = UIImagePickerController()
    
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
        
        EditEventTitleCellConfigurator.registerCell(tableView: view)
        EditEventTitleTextFieldCellConfigurator.registerCell(tableView: view)
        EditEventTextCellConfigurator.registerCell(tableView: view)
        EditEventBoldTextCellConfigurator.registerCell(tableView: view)
        EditEventSaveCellConfigurator.registerCell(tableView: view)
        EditEventAddPhotoCellConfigurator.registerCell(tableView: view)

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
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason != .committed {
            return
        }
        viewModel.dataSource?.title = textField.text ?? ""
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.dataSource?.text = textView.text
    }
    
    // MARK: - MediaPickerDelegate
    
    func makePhoto() {
        ImagePickerManager().openCamera(self) { image in
            print("image is \(image)")
            self.viewModel.dataSource?.mainImage = image
        }
    }
    
    func openGallery() {
        ImagePickerManager().openGallery(self) { image in
            print("image is \(image)")
            self.data.mainImage = image
        }
    }
    
    func save() {
        viewModel.save()
    }
    
}
