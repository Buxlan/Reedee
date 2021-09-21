//
//  PinnedEventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit
import Foundation

class ActionsTableCell: UITableViewCell,
                        ConfigurableCell,
                        CollectionViewDelegate, CollectionViewDataSource {
    // MARK: - Properties
    typealias DataType = QuickAction
    
    weak var delegate: UICollectionViewDelegate?
    weak var dataSource: UICollectionViewDataSource?
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    var timer: Timer?
    
//    private lazy var coloredView: UIView = {
//        let view = UIView()
//        view.backgroundColor = Asset.other2.color
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private lazy var collectionView: QuickActionsCollectionView = {
        let layout = QuickActionsCollectionLayout()
        let inset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        layout.sectionInset = inset
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
                
        let width: CGFloat = UIScreen.main.bounds.width - inset.left - inset.right
        let itemWidth: CGFloat = width / 2 - layout.minimumInteritemSpacing
        let itemHeight = itemWidth * 0.3
        let size = CGSize(width: itemWidth, height: itemHeight)
        layout.itemSize = size
        
        let view = QuickActionsCollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView (inside table cell)"
        view.backgroundColor = Asset.other1.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.register(ActionsCollectionCell.self,
                      forCellWithReuseIdentifier: ActionsCollectionCell.reuseIdentifier)
        
        view.delegate = self
        view.dataSource = self

        view.layer.shadowRadius = 10.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize()
        view.layer.shadowOpacity = 0.8
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        
        return view
    }()
        
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
        
    func configure(with data: DataType) {
        configureUI()
        startTimer()
    }
    
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
//        let collectionViewHeight: CGFloat = 300
        let constraints: [NSLayoutConstraint] = [
//            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] (_) in
            guard let self = self else {
                return
            }
                        
            let pageWidth = self.collectionView.frame.size.width
            let currentPage = Int(self.collectionView.contentOffset.x / pageWidth)

            var newItemIndex = currentPage + 1
            let numberOfPages = self.collectionView.numberOfItems(inSection: 0)
            if newItemIndex == numberOfPages {
                newItemIndex = 0
            }
            let indexPath = IndexPath(item: newItemIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc
    private func collectionViewLongPressHandle(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            timer?.invalidate()
            timer = nil
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            startTimer()
        }
    }    
   
}

extension ActionsTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension ActionsTableCell: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return .init(width: width, height: collectionView.bounds.height)
    }
    
}
