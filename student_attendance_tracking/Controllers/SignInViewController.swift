import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    private let signInView = SignInView()
    private let authService = AuthService()
    
    // MARK: - Lifecycle
    override func loadView() { 
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupActions()
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        signInView.signInBtn.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        signInView.signUpBtn.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func signInTapped() {
        
        guard let email = signInView.email.text, let password = signInView.password.text, !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Error", message: "Username / Password ?")
            return
        }
        
        authService.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.navigateToMain()
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc func signUpTapped() {
        guard let email = signInView.email.text, let password = signInView.password.text, !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Error", message: "Username / Password ?")
            return
        }
        
        authService.signUp(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.navigateToMain()
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    private func navigateToMain() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        present(mainTabBarController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
