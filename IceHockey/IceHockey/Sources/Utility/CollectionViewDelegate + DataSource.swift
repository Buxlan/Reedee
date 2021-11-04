//
//  CollectionViewDelegate + DataSource.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit

protocol CollectionViewDelegate: class {
    var delegate: UICollectionViewDelegate? { get set }
}

protocol CollectionViewDataSource: class {
    var dataSource: UICollectionViewDataSource? { get set }
}
