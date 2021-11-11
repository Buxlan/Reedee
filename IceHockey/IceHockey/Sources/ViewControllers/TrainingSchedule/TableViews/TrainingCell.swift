//
//  TrainingCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import UIKit

class TrainingCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = TrainingCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var dayTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.font = .regularFont14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 2
        view.addArrangedSubview(training0TextView)
        view.addArrangedSubview(training1TextView)
        view.addArrangedSubview(training2TextView)
        return view
    }()
    
    private lazy var training0TextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.font = .regularFont14
        return view
    }()
    
    private lazy var training1TextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.font = .regularFont14
        return view
    }()
    
    private lazy var training2TextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.font = .regularFont14
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
        contentView.addSubview(dayTextView)
        contentView.addSubview(stackView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dayTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            dayTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5, constant: -32),
            dayTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayTextView.heightAnchor.constraint(equalToConstant: 40),            
            
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5, constant: -32),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCollectionContent extension
extension TrainingCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        dayTextView.text = data.day
        dayTextView.textColor = Asset.textColor.color
        dayTextView.backgroundColor = Asset.other3.color
        
        stackView.backgroundColor = Asset.other3.color
        training1TextView.textColor = Asset.textColor.color
        training1TextView.backgroundColor = Asset.other3.color
        training2TextView.textColor = Asset.textColor.color
        training2TextView.backgroundColor = Asset.other3.color
        
        for (index, training) in data.trainings.enumerated() {
            let view = getTextView(at: index)
            view.isHidden = false
            view.text = "\(training.type.description): \(training.time)"
        }
        
        let numberOfTextViews = stackView.arrangedSubviews.count
        let trainingsCount = data.trainings.count
        if trainingsCount < numberOfTextViews {
            for index in trainingsCount..<numberOfTextViews {
                let view = getTextView(at: index)
                view.isHidden = true
            }
        }
        
    }
    
    func getTextView(at index: Int) -> UITextView {
        switch index {
        case 0:
            return training0TextView
        case 1:
            return training1TextView
        default:
            return training2TextView
        }
    }
    
}
