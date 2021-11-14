//
//  EditEventPhotoCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit

class EditEventPhotoCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = EditEventPhotoCellModel
    var data: DataType?
    var isInterfaceConfigured = false
    let cellHeight: CGFloat = 120
    
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
        view.isPagingEnabled = false
        view.register(EditEventPhotoCollectionCell.self, forCellWithReuseIdentifier: EditEventPhotoCollectionCellConfigurator.reuseIdentifier)
        view.register(EditEventAddPhotoCollectionCell.self, forCellWithReuseIdentifier: EditEventAddPhotoCollectionCellConfigurator.reuseIdentifier)
        
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
        data = nil
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
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventPhotoCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        data.collectionBase?.setupCollection(collectionView)
        collectionView.reloadData()
        
        collectionView.backgroundColor = data.backgroundColor
        collectionView.tintColor = data.tintColor
    }
    
}

extension EditEventPhotoCell: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = cellHeight - (collectionView.contentInset.left + collectionView.contentInset.right)
        let height = cellHeight - (collectionView.contentInset.top + collectionView.contentInset.bottom)
        return .init(width: width, height: height)
    }
    
}
