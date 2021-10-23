//
//  EditEventPhotoCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit
import Foundation

class EditEventPhotoCell: UITableViewCell, ConfigurableCell, CollectionViewDelegate {
    
    // MARK: - Properties
    typealias DataType = SportEvent
    
    weak var delegate: UICollectionViewDelegate?
    weak var dataSource: UICollectionViewDataSource?
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1
    
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
        view.register(EditEventPhotoCollectionCell.self,
                      forCellWithReuseIdentifier: EditEventPhotoCollectionCell.reuseIdentifier)
        
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
    
    // MARK: - Helper functions
        
    func configure(with data: DataType) {
        configureUI()
    }
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other2.color
        tintColor = Asset.other1.color
        contentView.addSubview(collectionView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
   
}

extension EditEventPhotoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: section)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource else { return UICollectionViewCell() }
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touched")
    }
}

extension EditEventPhotoCell: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return .init(width: width, height: collectionView.bounds.height)
    }
    
}
