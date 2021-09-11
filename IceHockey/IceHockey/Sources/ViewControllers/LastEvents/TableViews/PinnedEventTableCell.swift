//
//  PinnedEventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/7/21.
//

import UIKit
import Foundation

protocol ConfigurableCell {
    static var reuseIdentifier: String { get }
    var isInterfaceConfigured: Bool { get set }
        
    associatedtype DataType
    func configure(with data: DataType)
}
extension ConfigurableCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

protocol ContainedCollectionViewCell {
    var delegate: UICollectionViewDelegate? { get set }
    var dataSource: UICollectionViewDataSource? { get set }
}

class PinnedEventTableCell: UITableViewCell, ConfigurableCell, ContainedCollectionViewCell {
    
    // MARK: - Properties
    typealias DataType = SportEvent
    
    weak var delegate: UICollectionViewDelegate?
    weak var dataSource: UICollectionViewDataSource?
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    var cellHeight: CGFloat = 300
    var timer: Timer?
    
    private lazy var coloredView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.other2.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = EventCollectionViewLayout()
        layout.delegate = self
//        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = .init(width: cellHeight * imageAspectRate, height: cellHeight)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.accessibilityIdentifier = "collectionView (inside table cell)"
        view.backgroundColor = Asset.other1.color
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.register(PinnedEventCollectionCell.self,
                      forCellWithReuseIdentifier: PinnedEventCollectionCell.reuseIdentifier)
        
        view.delegate = self
        view.dataSource = self
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(collectionViewLongPressHandle))
//        gesture.numberOfTouchesRequired = 1
//        gesture.numberOfTapsRequired = 1
        gesture.minimumPressDuration = 1.0
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    private lazy var pageControl: ScrollingPageControl = {
        let view = ScrollingPageControl()
        let numberOfPages = collectionView.numberOfItems(inSection: 0)
        view.numberOfPages = numberOfPages
//        view.currentPage = 0
//        view.currentPageIndicatorTintColor = Asset.accent0.color
//        view.hidesForSinglePage = true
//        let numberOfPages = collectionView.numberOfItems(inSection: 0)
//        view.numberOfPages = numberOfPages
//        view.pageIndicatorTintColor = Asset.other1.color
//        view.isHidden = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: DataType) {
        configureUI()
        startTimer()
    }
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other2.color
        tintColor = Asset.other1.color
        contentView.addSubview(coloredView)
        coloredView.addSubview(collectionView)
        coloredView.addSubview(pageControl)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let collectionViewHeight = cellHeight
        let constraints: [NSLayoutConstraint] = [
            coloredView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coloredView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            coloredView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: coloredView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: coloredView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: coloredView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            collectionView.bottomAnchor.constraint(equalTo: coloredView.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: coloredView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: coloredView.bottomAnchor, constant: -16),
            pageControl.widthAnchor.constraint(equalTo: coloredView.widthAnchor, multiplier: 0.25),
            pageControl.heightAnchor.constraint(equalToConstant: 16)
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

extension PinnedEventTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
//    func collectionView(_ collectionView: UICollectionView,
//                        willDisplay cell: UICollectionViewCell,
//                        forItemAt indexPath: IndexPath) {
//
//        startTimer()
//    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
//
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
//        pageControl.currentPage = Int(page)
        startTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(page)
    }
}

extension PinnedEventTableCell: EventCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return .init(width: width, height: collectionView.bounds.height)
    }
    
}
