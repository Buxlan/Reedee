//
//  PinnedEventsLayout.swift
//  IceHockey
//
//  Created by  Buxlan on 9/20/21.
//

import UIKit

class QuickActionsCollectionLayout: UICollectionViewFlowLayout {
    
    var spacing: CGFloat = 8    
    
    private var cache: [UICollectionViewLayoutAttributes] = []
        
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
//
//    private var contentHeight: CGFloat = 0
//
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return cache
//    }
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item]
//    }
}

extension QuickActionsCollectionLayout {
//    override func prepare() {
//
//        guard let collectionView = collectionView else {
//            return
//        }
//
//        cache.removeAll()
//
//        var yOrigin: CGFloat = 0
//        var xOrigin: CGFloat = 0
//
//        for item in 0..<collectionView.numberOfItems(inSection: 0) {
//            let indexPath = IndexPath(item: item, section: 0)
//            let itemSize = self.itemSize
//
//            if xOrigin + itemSize.width > contentWidth {
//                // 5. If adding another row will be exceeding the
//                // the width of the collectionView's content, we
//                // go down to a new row
//                xOrigin = 0
//                yOrigin += itemSize.height + spacing
//            }
//
//            let frame = CGRect(x: xOrigin, y: yOrigin, width: itemSize.width, height: itemSize.height)
//
//            xOrigin += itemSize.width + spacing
//
//            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
//            attributes.frame = frame
//
//            cache.append(attributes)
//
//            contentHeight = yOrigin + itemSize.height + spacing
//        }
//
//    }
}
