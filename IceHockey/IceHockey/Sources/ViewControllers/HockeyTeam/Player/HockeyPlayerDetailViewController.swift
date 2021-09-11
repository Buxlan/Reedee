//
//  HockeyPlayerDetailViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

class HockeyPlayerDetailViewController: UIViewController {
    
    // MARK: - Properties
    var staff: SportPlayer? {
        didSet {
            viewModel.staff = staff
            configureUIData()
        }
    }
    var viewModel = HockeyPlayerDetailViewModel()
        
    private lazy var imageView: UIImageView = {
        let image = Asset.squadLogo.image
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var displayNameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let constraints: [NSLayoutConstraint] = [
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            displayNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            displayNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),

            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let subviews: [UIView] = [imageView, displayNameLabel, descriptionLabel]
        let view = UIStackView(arrangedSubviews: subviews)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(displayNameLabel)
        view.addSubview(descriptionLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }
    
    // MARK: - Hepler functions
    private func configureUI() {
        view.addSubview(scrollView)
        configureUIData()
    }
    
    private func configureUIData() {
        guard let staff = staff else {
            return
        }
        let image = staff.image
        imageView.image = image
        let displayName = "\(L10n.Staff.player)\n\(staff.displayName)"
        displayNameLabel.text = displayName
        let description = "\(L10n.Staff.playerDescription)\n#\(staff.gameNumber)\nString\nString\nString\nString\nString\nString\nString\nString\nString\nString\nString\nString\nString\nString"
        descriptionLabel.text = description
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.Squads.tabBarItemTitle
        let image = Asset.shoppingCart.image.resizeImage(to: 24,
                                                    aspectRatio: .current,
                                                    with: view.tintColor)
        tabBarItem.image = image
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = staff?.displayName ?? "?"
//        navigationController?.navigationItem.titleView = titleView
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.backBarButtonItem?.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
