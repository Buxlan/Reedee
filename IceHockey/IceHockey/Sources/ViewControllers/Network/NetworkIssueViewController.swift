//
//  NetworkIssueViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.10.2022.
//

import UIKit

class NetworkIssueViewController: UIViewController {
    
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "textLabel"
        view.numberOfLines = 4
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        view.textColor = Colors.Gray.dark
        view.text = L10n.Error.networkUnavailable
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textLabel)
                
        let constraints: [NSLayoutConstraint] = [
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            textLabel.heightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
