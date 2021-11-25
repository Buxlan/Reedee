//
//  DataSnapshotsCollection + Iterator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/25/21.
//

import Firebase

class DataSnapshotsCollection {
    
    typealias Element = DataSnapshotsPortionCollection
    lazy var items: [Element] = []
    private let portionSize = 10
    
    func append(_ item: DataSnapshot) {
        let lastIndex = items.count - 1
        if lastIndex >= 0 {
            // get last
            let portionCount = items[lastIndex].count
            if portionCount < portionSize {
                items[lastIndex].append(item)
            } else {
                let newPortion = DataSnapshotsPortionCollection()
                newPortion.append(item)
                items.append(newPortion)
            }
        } else {
            // list is empty
            let newPortion = DataSnapshotsPortionCollection()
            newPortion.append(item)
            items.append(newPortion)
        }
    }
    
    var count: Int {
        items.count
    }
    
    var isEmpty: Bool {
        items.count == 0
    }
    
}

extension DataSnapshotsCollection: Sequence {
    
    func makeIterator() -> DataSnapshotsIterator {
        return DataSnapshotsIterator(collection: self)
    }
    
}

class DataSnapshotsIterator: IteratorProtocol {
    
    private let collection: DataSnapshotsCollection
    private var index = 0
    
    init(collection: DataSnapshotsCollection) {
        self.collection = collection
    }
    
    func first() {
        index = 0
    }
    
    func last() {
        index = collection.count - 1
    }
    
    func next() -> DataSnapshotsPortionCollection? {
        let item = index < collection.items.count ? collection.items[index] : nil
        index = item == nil ? index : index + 1
        return item
    }
    
}
