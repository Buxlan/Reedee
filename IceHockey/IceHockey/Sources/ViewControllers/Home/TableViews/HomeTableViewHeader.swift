//
//  HomeTableViewHeader.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import UIKit
import Foundation

class HomeTableViewHeader: UIView,
                           CollectionViewDelegate,
                           CollectionViewDataSource {
        
    // MARK: - Properties
    
    weak var delegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }
    weak var dataSource: UICollectionViewDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    
    private lazy var collectionView: QuickActionsCollectionView = {
        let layout = QuickActionsCollectionLayout()
        let inset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        layout.sectionInset = inset
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
                
        let width: CGFloat = UIScreen.main.bounds.width - inset.left - inset.right
        let itemWidth: CGFloat = width / 2 - layout.minimumInteritemSpacing
        let itemHeight = frame.height / 2 - layout.minimumInteritemSpacing * 2
        let size = CGSize(width: itemWidth, height: itemHeight)
        layout.itemSize = size
        
        let view = QuickActionsCollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView (inside table cell)"
        view.backgroundColor = Asset.accent1.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.register(ActionsCollectionCell.self,
                      forCellWithReuseIdentifier: ActionsCollectionCell.reuseIdentifier)
        return view
    }()
        
    // MARK: - Init
    
    // MARK: - Helper functions
        
    func configureUI() {
        if isInterfaceConfigured { return }
        self.backgroundColor = Asset.accent0.color
        tintColor = Asset.other1.color
        self.addSubview(collectionView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
