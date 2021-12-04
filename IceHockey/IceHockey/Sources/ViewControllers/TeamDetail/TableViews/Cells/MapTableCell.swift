//
//  MapTableCell.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 10/31/21.
//

import UIKit
import MapKit

class MapTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var data: DataType?
    var isInterfaceConfigured: Bool = false
    
    private lazy var titleLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let view = InsetLabel(insets: insets)
        view.numberOfLines = 4
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.font = .boldFont17
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.isZoomEnabled = true
        view.isScrollEnabled = true
        view.isRotateEnabled = true
        view.isPitchEnabled = true
        view.showsCompass = true
        view.showsScale = true
        view.showsTraffic = false
        view.showsBuildings = true
        view.showsUserLocation = true
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(titleLabel)
        contentView.addSubview(mapView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let mapViewHeightConstraint = mapView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75)
        mapViewHeightConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: mapView.topAnchor),
            mapView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mapView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapViewHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension MapTableCell: ConfigurableCollectionContent {
        
    typealias DataType = MapCellModel
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        mapView.removeAnnotations(mapView.annotations)
        if let location = data.location {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let annotation = prepareAnnotation(with: data, coordinate: coordinate)
            mapView.centerToCoordinate(coordinate)
            mapView.addAnnotation(annotation)
        }
        titleLabel.text = data.displayName + " " + L10n.Team.onTheMapTitle
        titleLabel.font = data.font
        titleLabel.textColor = data.textColor
        titleLabel.backgroundColor = data.backgroundColor
        contentView.backgroundColor = data.backgroundColor
    }
    
    private func prepareAnnotation(with data: DataType, coordinate: CLLocationCoordinate2D) -> MKAnnotation {
        let annotation = SportTeamAnnotation(title: data.displayName, coordinate: coordinate)
        return annotation
    }
    
}

// MARK: - MapView delegate
extension MapTableCell: MKMapViewDelegate {
        
}
