import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    lazy var signInViewController = SignInViewController()
    
    override func loadView() {
        self.view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        settingsView.logOutButton.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
    }
    
    @objc private func handleLogOut() {
        do {
            try Auth.auth().signOut()
            
            self.signInViewController.modalPresentationStyle = .fullScreen
            self.present(self.signInViewController, animated: true, completion: nil)
        } catch {
            print("Error while logout")
        }
    }
}
