//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase
import FirebaseDatabaseUI

protocol InputData {
    associatedtype DataType
    var inputData: DataType? { get set }
}

class HomeViewModel {
    weak var delegate: CellUpdatable? {
        didSet {
            dataSource = FUITableViewDataSource(query: getQuery()) { (tableView, indexPath, snap) -> UITableViewCell in
                guard let event = SportEvent(snapshot: snap),
                      let delegate = self.delegate else { return UITableViewCell() }
                if let image = self.images[event] {
                    delegate.updateCellImage(event: event,
                                         indexPath: indexPath,
                                         image: image)
                } else {
                    self.downloadImage(event, indexPath: indexPath)
                }
                return delegate.configureCell(at: indexPath, event: event)
            }
        }
    }
    var dataSource: FUITableViewDataSource?
    private var databaseReference: DatabaseReference = {
        Database.database(url: "https://icehockey-40e64-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }()
    private var storageReference: StorageReference = {
        Storage.storage().reference().child("events")
    }()
    
    private var images: [SportEvent: UIImage?] = [:]
    
    // MARK: Lifecircle
        
    // MARK: - Hepler functions
    
    func downloadImage(_ event: SportEvent, indexPath: IndexPath) {
        let ref = storageReference.child(event.imagePath)
        let maxSize: Int64 = 3 * 1024 * 1024
        ref.getData(maxSize: maxSize) { (data, error) in
            if let error = error {
                print(error)
            }
            guard let data = data,
                  let image = UIImage(data: data) else {
                print(error.debugDescription)
                return
            }
            self.images[event] = image
            self.delegate?.updateCellImage(event: event, indexPath: indexPath, image: image)
        }
    }
    
    func getEventImage(_ event: SportEvent) -> UIImage? {
        if let image = images[event] {
            return image
        } else {
            return UIImage()
        }
    }
    
}

extension HomeViewModel {
    private func getQuery() -> DatabaseQuery {
        return databaseReference.child("events")
    }
}
