//
//  EventDetailPhotoCollectionViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import UIKit
import Firebase
import SDWebImage

class EventDetailPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    typealias DataType = EventDetailPhotoCellModel
    
    internal var isInterfaceConfigured: Bool = false
    let imageAspectRate: CGFloat = 1
    let imageHeight: CGFloat = UIScreen.main.bounds.width
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = CorneredView(corners: [.topLeft, .topRight], radius: cornerRadius)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.roundCorners(corners: [.allCorners], radius: 40)
//        view.clipsToBounds = true
        return view
    }()
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = UIView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
//        view.image = Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        return view
    }()
    private lazy var placeholderImage: UIImage = {
        Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    
    // MARK: Lifecircle
    
    override func prepareForReuse() {
        dataImageView.image = nil
        isInterfaceConfigured = false
    }
    
    // MARK: Helper methods
    
    func configureInterface() {
        if isInterfaceConfigured { return }
        tintColor = UIColor.black
        backgroundColor = Asset.other3.color
        contentView.clipsToBounds = true
//        let backView = UIView()
//        backView.backgroundColor = Asset.other1.color
//        backgroundView = backView
//        contentView.addSubview(roundedView)
        
//        contentView.addSubview(shadowView)
        contentView.addSubview(dataImageView)
//        contentView.addSubview(bottomBackgroundView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            dataImageView.heightAnchor.constraint(equalToConstant: imageHeight),
//            dataImageView.heightAnchor.constraint(equalToConstant: 300),
            dataImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)

//            bottomBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            bottomBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            bottomBackgroundView.topAnchor.constraint(equalTo: dataImageView.bottomAnchor),
//            bottomBackgroundView.heightAnchor.constraint(equalToConstant: 40),
//            bottomBackgroundView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

//            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            shadowView.topAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
//            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            shadowView.heightAnchor.constraint(equalTo: bottomBackgroundView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension EventDetailPhotoCollectionViewCell: ConfigurableCollectionContent {
    
    // MARK: - Helper functions
    func configure(with data: DataType) {
        configureInterface()
        if dataImageView.image == nil {
            let path = "events/\(data.eventID)"
            let imageName = ImagesManager.getImageName(forKey: data.imageID)
            ImagesManager.shared.getImage(withName: imageName, path: path) { (image) in
                self.dataImageView.image = image
            }
        }
    }
    
}
