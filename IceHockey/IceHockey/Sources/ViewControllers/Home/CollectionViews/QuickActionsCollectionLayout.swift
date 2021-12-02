//
//  QuickActionsCollectionLayout.swift
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

}
