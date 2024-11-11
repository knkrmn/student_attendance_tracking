import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    var choosenStudent : Student?
    
    lazy var signInViewController : SignInViewController = {
        return SignInViewController()
    }()
    
    lazy var studentDetailViewController : StudentDetailViewController = {
        return StudentDetailViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleLogin()
        view.backgroundColor = .white
        self.title = "Admin"
        
        //uploadFakeData()
    }
    
    func handleLogin() {
        // Giriş yapan kullanıcıyı kontrol et
        guard let currentUser = Auth.auth().currentUser else {
            print("No user is logged in.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").whereField("userMail", isEqualTo: currentUser.email!)
        
        userRef.getDocuments { [weak self] (snapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                if let userMail = currentUser.email {
                    let studentRef = db.collection("students").whereField("parentMail", isEqualTo: userMail)
                    studentRef.getDocuments() { [weak self] (snapshot, error) in
                        guard let self = self else { return }
                        
                        if let error = error {
                            print("Error fetching user document: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let documents = snapshot?.documents, !documents.isEmpty else {
                            print("You are not a valid user")
                            return
                        }
                        
                        self.redirectToUserPage()

                    }
                    
                }
                
                return
            }
            
            let document = documents[0]
            
            if let userType = document.data()["userType"] as? String {
                
                if userType == "admin" {
                    print("User is an admin. Redirecting to admin page.")
                    self.redirectToAdminPage()
                }
                
            } else {
                print("Yoksa Burada mı")
                self.redirectToUserPage()
                print("userType not found in the document.")
            }
        }
    }
    
    func redirectToAdminPage() {
        
        let adminVC = AdminTabBarController()
        let navController = UINavigationController(rootViewController: adminVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
        
    }
    
    func redirectToUserPage() {
        let userVC = ParentTabBarController()
        let navController = UINavigationController(rootViewController: userVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "You are not valid user", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            do {
                try Auth.auth().signOut()
                
                self.signInViewController.modalPresentationStyle = .fullScreen
                self.present(self.signInViewController, animated: true, completion: nil)
            } catch {
                print("Error while logout")
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
