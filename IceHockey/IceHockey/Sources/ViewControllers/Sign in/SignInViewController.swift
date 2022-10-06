//
//  SignInViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import SnapKit
import RxSwift
import RxCocoa
import GoogleSignIn
import Firebase

class SignInViewController: UIViewController, SignInViewProtocol {
    
    // MARK: - Properties
    
    var onCompletion: CompletionBlock?
    
    let viewModel = SignInViewModel()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "logoImageView"
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        let image = Asset.logo.image
        view.setImage(image)
        return view
    }()
    
    private lazy var loginTextField = LoginTextField()    
    private lazy var passwordTextField = PasswordTextField()
    
    private lazy var signInButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Profile.signIn, for: .normal)
        view.backgroundColor = Colors.Accent.blue
        view.setTitleColor(.white, for: .normal)
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 8
        view.contentEdgeInsets = .init(top: 4, left: 12, bottom: 4, right: 12)
        view.titleLabel?.font = Fonts.Regular.title
        view.addTarget(self, action: #selector(loginUsingEmailHandle), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var signUpButton: UIButton = {
        let title = L10n.Profile.signUpHint + L10n.Profile.signUp
        let view = UIButton()
        view.setTitleColor(Colors.Gray.medium, for: .normal)
        view.contentEdgeInsets = .init(top: 4, left: 12, bottom: 4, right: 12)
        view.titleLabel?.font = Fonts.Regular.body
        view.addTarget(self, action: #selector(signUpHandle), for: .touchUpInside)
        let attrStr = getAttributedString(fullString: title,
                                          changeableSubstring: L10n.Profile.signUp)
        view.setAttributedTitle(attrStr, for: .normal)
        return view
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Profile.forgetPassword, for: .normal)
        view.setTitleColor(Colors.Accent.blue, for: .normal)
        view.contentEdgeInsets = .init(top: 4, left: 12, bottom: 4, right: 12)
        view.titleLabel?.font = Fonts.Regular.body
        view.addTarget(self, action: #selector(forgetPasswordHandle), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Accent.blue
        return view
    }()
    
    private lazy var googleButton: GIDSignInButton = {
        let view = GIDSignInButton()
        view.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        
        return view
    }()
    
    // MARK: - Lifecircle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.delegate = nil
    }

}

// MARK: - Helper methods

extension SignInViewController {
    
    private func configureViewModel() {
        loginTextField.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.loginBehaviorRelay)
            .disposed(by: viewModel.disposeBag)
        
        passwordTextField.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.passwordBehaviorRelay)
            .disposed(by: viewModel.disposeBag)
        
        signInButton.rx.tap.bind {
            print("button tapped")
        }.disposed(by: viewModel.disposeBag)
        
        viewModel.isValid()
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.Gray.ultraLight
        view.addSubview(topBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
//        view.addSubview(googleButton)
        view.addSubview(forgetPasswordButton)
        view.addSubview(signUpButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        topBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.top)
            make.centerX.equalTo(view.layoutMarginsGuide.snp.centerX)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.layoutMarginsGuide.snp.width).offset(-32)
            make.height.equalTo(36)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.layoutMarginsGuide.snp.width).offset(-32)
            make.height.equalTo(36)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.lessThanOrEqualToSuperview()
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.width.lessThanOrEqualToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(forgetPasswordButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.width.lessThanOrEqualToSuperview()
        }
        
        
//        googleButton.snp.makeConstraints { make in
//            make.top.equalTo(signInButton.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//            make.height.width.lessThanOrEqualToSuperview()
//        }
        
    }
    
}

// MARK: - SignInViewController
extension SignInViewController {
    
    @objc private func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID
        else {
            return
        }
        
        // Create Google Sign In configuration object
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [weak self] user, error in
            if let error = error {
                log.debug("Troubles with google auth: \(error)")
                return
            }
            
            guard let self = self,
                  let authentication = user?.authentication,
                  let token = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: token,
                                                           accessToken: authentication.accessToken)
            
            UserDefaultsWrapper.token = token
            self.onCompletion?()
            
        }
        
    }
    
}

// MARK: - Actions
private extension SignInViewController {
    
    @objc func loginUsingEmailHandle() {
        viewModel.loginWithEmail { [weak self] in
            self?.onCompletion?()
        }
    }
    
    @objc func signUpHandle() {
        
    }
    
    @objc func forgetPasswordHandle() {
        
    }
    
}

// MARK: - Private methods
extension SignInViewController {
    func getAttributedString(fullString: String, changeableSubstring: String)
    -> NSAttributedString {
        
        let attrStr = NSMutableAttributedString(string: fullString,
                                                attributes: [:])
        
        let nsFullString = fullString as NSString,
            range = nsFullString.range(of: changeableSubstring)
        attrStr.addAttribute(NSMutableAttributedString.Key.foregroundColor,
                             value: Colors.Accent.blue,
                             range: range)
        return attrStr
    
    }
}
