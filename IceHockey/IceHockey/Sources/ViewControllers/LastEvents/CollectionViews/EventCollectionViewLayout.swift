//
//  EventCollectionViewLayout.swift
//  IceHockey
//
//  Created by  Buxlan on 9/9/21.
//

import UIKit

protocol EventCollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize
}

class EventCollectionViewLayout: UICollectionViewLayout {
    
    // CustomCollectionViewLayoutDelegate
    weak var delegate: EventCollectionViewLayoutDelegate?
    var spacing: CGFloat = 8
    
    private var cache: [UICollectionViewLayoutAttributes] = []
        
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.height - (collectionView.contentInset.bottom + collectionView.contentInset.top)
    }
    
    private var contentWidth: CGFloat = 0        
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

extension EventCollectionViewLayout {
    override func prepare() {
        
        guard let collectionView = collectionView,
              let delegate = delegate else {
            return
        }
        
        cache.removeAll()
        
        let yOrigin: CGFloat = 0
        var xOrigin: CGFloat = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemSize = delegate.collectionView(collectionView, getSizeAtIndexPath: indexPath)
                        
//            if xOrigin + itemSize.width > contentWidth {
//                // 5. If adding another row will be exceeding the
//                // the width of the collectionView's content, we
//                // go down to a new row
//                xOrigin = 0
//                yOrigin += itemSize.height
//            }
            
            let frame = CGRect(x: xOrigin, y: yOrigin, width: itemSize.width, height: itemSize.height)
            
            xOrigin += itemSize.width
            
            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            attributes.frame = frame
            
            cache.append(attributes)
            
            contentWidth = max(contentWidth, xOrigin)
        }
        
    }
}
