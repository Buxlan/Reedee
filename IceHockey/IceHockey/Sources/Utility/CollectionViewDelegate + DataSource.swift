//
//  CollectionViewDelegate + DataSource.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit

protocol CollectionViewDelegate: AnyObject {
    var delegate: UICollectionViewDelegate? { get set }
}

protocol CollectionViewDataSource: AnyObject {
    var dataSource: UICollectionViewDataSource? { get set }
}
