//
//  PinnedCollectionView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/19/21.
//

import UIKit
 
class QuickActionsCollectionView: UICollectionView, Typeable {
    
    var type: LastEventsSectionType = .actions
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        var size = self.contentSize
//        size.width += self.contentInset.left + self.contentInset.right
//        size.height += self.contentInset.top + self.contentInset.bottom
        return size
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }    
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
