//
//  EventDetailPhotoTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import UIKit

class EventDetailPhotoView: UITableViewCell, CollectionViewDelegate {
    
    // MARK: - Properties
    
    typealias DataType = [EventDetailPhotoCellModel]
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1
//    var timer: Timer?
    weak var delegate: UICollectionViewDelegate?
    private var viewModel = EventDetailPhotoViewModel()
    
    private lazy var collectionView: PhotoCollectionView = {
        let layout = EventDetailPhotoCollectionViewLayout()
        layout.delegate = self
        let view = PhotoCollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView (inside table cell)"
        view.backgroundColor = Asset.other1.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.register(EventDetailPhotoCollectionViewCell.self,
                      forCellWithReuseIdentifier: EventDetailPhotoCollectionViewCell.reuseIdentifier)
        
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    private lazy var pageControl: ScrollingPageControl = {
        let view = ScrollingPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(pageControl)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
//            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
//            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            pageControl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            pageControl.heightAnchor.constraint(equalToConstant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EventDetailPhotoView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        viewModel.setImageData(data)
        pageControl.numberOfPages = data.count
        collectionView.reloadData()
    }
    
}

extension EventDetailPhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = viewModel.item(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.rowId,
                                                      for: indexPath)
        row.config.configure(view: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("touched")
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(page)
    }
}

extension EventDetailPhotoView: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return .init(width: width, height: width)
    }
    
}
