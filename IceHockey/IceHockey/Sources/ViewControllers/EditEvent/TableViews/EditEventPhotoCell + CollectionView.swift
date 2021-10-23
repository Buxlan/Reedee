//
//  EditEventPhotoCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit

class EditEventPhotoCell: UITableViewCell, CollectionViewDelegate {
    
    // MARK: - Properties
    
    typealias DataType = [String]
    typealias HandlerType = EditEventHandler
    var isInterfaceConfigured = false
    weak var delegate: UICollectionViewDelegate?
    private var viewModel = EditEventPhotoViewModel()
    let cellHeight: CGFloat = 80
    
    private lazy var collectionView: PhotoCollectionView = {
        let layout = EditEventPhotoCollectionViewLayout()
        layout.delegate = self
        let view = PhotoCollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView (inside table cell)"
        view.backgroundColor = Asset.other1.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        
        EditEventAddPhotoCollectionCellConfigurator.registerCell(collectionView: view)
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
        
    // MARK: - Lifecircle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other2.color
        tintColor = Asset.other1.color
//        contentView.addSubview(coloredView)
        contentView.addSubview(collectionView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventPhotoCell: ConfigurableActionCell {
    
    func configure(with data: DataType, handler: HandlerType) {
        configureUI()
        viewModel.handler = handler
        viewModel.imagesNames = data
        collectionView.reloadData()
    }
    
}

extension EditEventPhotoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.item(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseIdentifier,
                                                      for: indexPath)
        item.configure(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touched")
    }
    
}

extension EditEventPhotoCell: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = cellHeight - (collectionView.contentInset.left + collectionView.contentInset.right)
        let height = cellHeight - (collectionView.contentInset.top + collectionView.contentInset.bottom)
        return .init(width: width, height: height)
    }
    
}
