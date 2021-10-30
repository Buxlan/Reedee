//
//  TeamDetailHeaderView.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 10/30/21.
//

import UIKit
import CoreLocation
import MapKit

struct TeamDetailHeaderViewModel {
    
    let value: UniData
    let viewType: ViewType
    
    init(value: UniData, viewType: ViewType) {
        self.value = value
        self.viewType = viewType
    }
}

class TeamDetailHeaderView: UIView {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel3"
        view.numberOfLines = 2
        view.text = L10n.Events.inputTitle
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
        
}

// MARK: - Helper methods
extension TeamDetailHeaderView {
    
    func configureUI() {
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -32)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configure(with model: TeamDetailHeaderViewModel) {
        
    }
    
}
