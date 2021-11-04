//
//  PhotoCollectionView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/20/21.
//

import UIKit

class PhotoCollectionView: UICollectionView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
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
