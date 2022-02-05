//
//  FinanceRouterButton.swift
//  TMKTitanFramework
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 05.02.2022.
//

import SnapKit

class FinanceRouterButton: UIView {

    // MARK: - Properties
    
    var onSelect = {}
    
    private var backgroundView: CorneredView = {
        let cornerRadius: CGFloat = 6.0
        let view = CorneredView(corners: [.allCorners], radius: cornerRadius)
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.contentMode = .left
        view.textAlignment = .left
        view.font = ResourceUtil.getRegularFont(17)
        view.textColor = .black
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = Asset.chevronRight.image
            .withRenderingMode(.alwaysTemplate)
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = image
        view.tintColor = .black
        
        return view
    }()
    
    // MARK: - Lifecircle

    init(title: String, image: UIImage) {
        super.init(frame: CGRect.zero)

        configureInterface(title, image)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    private func configureInterface(_ title: String, _ image: UIImage) {
        
        let image = image.withRenderingMode(.alwaysTemplate)
        
        imageView.image = image
        titleLabel.text = title
        
        addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(arrowImageView)
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(viewTapped))
        addGestureRecognizer(gesture)
        
    }

    private func configureConstraints() {
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(15)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-15)
            make.height.equalTo(25)
            make.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
    }
    
}

// MARK: - Actions

extension FinanceRouterButton {
    
    @objc private func viewTapped() {
        onSelect()
    }
    
}

