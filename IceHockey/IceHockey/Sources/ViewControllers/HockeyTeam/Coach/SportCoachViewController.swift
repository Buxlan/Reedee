//
//  CoachViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

class SportCoachViewController: UIViewController {
    
    // MARK: - Properties
    var staff: SportCoach? {
        didSet {
            viewModel.staff = staff
        }
    }
    var viewModel = SportCoachDetailViewModel()
        
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        let image = Asset.squadLogo.image
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        let displayNameLabel = UILabel()
        displayNameLabel.numberOfLines = 3
        displayNameLabel.textAlignment = .center
        let displayName = "\(L10n.Staff.coach)\n\(staff?.displayName ?? "?")"
        displayNameLabel.text = displayName
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(displayNameLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = staff?.description
        scrollView.addSubview(descriptionLabel)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor),
            displayNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            displayNameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            displayNameLabel.heightAnchor.constraint(equalTo: scrollView.widthAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        return scrollView
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
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
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
