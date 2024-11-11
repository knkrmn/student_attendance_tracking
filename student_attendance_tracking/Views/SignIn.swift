import UIKit

class SignInView: UIView {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    lazy var heading    = CustomLabel(text: "Instagram Clone App")
    lazy var email      = CustomTextField(isSecureText: false, placeHolder: "Email")
    lazy var password   = CustomTextField(isSecureText: true, placeHolder: "Password")
    lazy var signInBtn  = CustomButton(title :"Sign In")
    lazy var signUpBtn  = CustomButton(title :"Sign Up")
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInBtn, signUpBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var homepageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heading, email, password, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    
    // MARK: - Setup UI
    private func setupStackView() {
        self.addSubview(homepageStackView)
        homepageStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homepageStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            homepageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            homepageStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
}
