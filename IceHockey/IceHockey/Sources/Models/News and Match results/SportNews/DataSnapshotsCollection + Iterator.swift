//
//  DataSnapshotsCollection + Iterator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/25/21.
//

import Firebase
import Foundation

struct SnapshotsSection {
    
    var items: [DataSnapshot] = []
    
    mutating func append(_ item: DataSnapshot) {
        self.items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
}

class DataSnapshotsCollection {
    
    typealias Element = SnapshotsSection
    lazy var items: [Element] = []
    private let sectionSize: UInt
    
    func appendSection() {
        let newPortion = SnapshotsSection()
        items.append(newPortion)
    }
    
    func appendItem(_ item: DataSnapshot) {
        let lastIndex = items.count - 1
        if lastIndex >= 0 {
            // get last
            let portionCount = items[lastIndex].count
            if portionCount < sectionSize {
                items[lastIndex].append(item)
            } else {
                let newPortion = SnapshotsSection(items: [item])
                items.append(newPortion)
            }
        } else {
            // list is empty
            let newPortion = SnapshotsSection(items: [item])
            items.append(newPortion)
        }
    }
    
    var count: Int {
        items.count
    }
    
    var isEmpty: Bool {
        items.count == 0
    }
    
    init(portionSize: UInt = 10) {
        self.sectionSize = portionSize
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
    
    @discardableResult func last() -> SnapshotsSection? {
        if collection.count > 0 {
            index = collection.count - 1
            return collection.items[index]
        } else {
            index = 0
            return nil
        }
    }
    
    func previous() -> SnapshotsSection? {
        index -= 1
        let item = (index > 0 && index < collection.items.count) ? collection.items[index] : nil
        return item
    }
    
    func next() -> SnapshotsSection? {
        let item = index < collection.items.count ? collection.items[index] : nil
        index = item == nil ? index : index + 1
        return item
    }
    
    func current() -> SnapshotsSection? {
        index < collection.items.count ? collection.items[index] : nil        
    }
    
}
