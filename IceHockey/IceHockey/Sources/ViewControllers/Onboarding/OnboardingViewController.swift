//
//  OnboardingViewController.swift
//  Places
//
//  Created by  Buxlan on 7/22/21.
//

import UIKit

class OnboardingViewController: UIViewController, OnboardingViewProtocol {
    
    // MARK: - Properties
    
    var onCompletion: CompletionBlock?
  
    private var viewModel: OnboardingViewModel
    
    private lazy var logoLabel: UILabel = {
        let view = UILabel()
        let text = L10n.App.name
        let attr: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attrStr = NSAttributedString(string: text, attributes: attr)
        view.attributedText = attrStr
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = Fonts.Regular.title
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let height: CGFloat = 20
        let view = UIButton()
        view.setImage(Asset.xmark.image.resizeImage(to: height,
                                                    aspectRatio: .square,
                                                    with: .clear), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentHorizontalAlignment = .right
        
//        if let imageView = view.imageView {
//            imageView.contentMode = .scaleAspectFit
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.deactivate(imageView.constraints)
//            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//            imageView.widthAnchor.constraint(equalToConstant: height).isActive = true
//            imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
//        }
        
        view.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.other0.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = viewModel.image
        imageView.backgroundColor = Asset.other1.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = viewModel.title
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = Fonts.Regular.title
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        
        let view = UILabel()
        view.text = viewModel.text
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        //        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.font = Fonts.Regular.title
        
        return view
        
    }()
    
    private lazy var buttonSkip: OnboardingSkipButton = {
        let view = OnboardingSkipButton(title: L10n.Onboarding.Buttons.continue,
                                          image: nil)
        view.setTitleColor(.black, for: .normal)
        view.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        view.backgroundColor = Colors.Accent.blue
        view.setTitleColor(Colors.Gray.ultraLight, for: .normal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    // MARK: - Lifecircle
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(logoLabel)
        view.addSubview(dismissButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(buttonSkip)
                
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other1.color
        buttonSkip.isHidden = viewModel.isButtonSkipEnabled ? false : true
        
        configureConstraints()
        
    }
    
    // MARK: - Helper methods
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            logoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                           constant: 8),
            logoLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            logoLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            dismissButton.centerYAnchor.constraint(equalTo: logoLabel.centerYAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 32),
            dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            //            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -8),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),
            
            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            //            textLabel.bottomAnchor.constraint(equalTo: buttonFuther.topAnchor, constant: -8),
            textLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            
            buttonSkip.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonSkip.widthAnchor.constraint(equalToConstant: 150),
            buttonSkip.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                               constant: -60),
            buttonSkip.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func dismissTapped() {
        onCompletion?()
    }
    
}
