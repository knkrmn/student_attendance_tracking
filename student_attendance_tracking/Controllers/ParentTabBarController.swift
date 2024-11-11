import UIKit

class ParentTabBarController: UITabBarController {
    
    // MARK: - Properties
    lazy var scoreboardViewController: ScoreboardViewController = {
        return ScoreboardViewController()
    }()

    lazy var studentDetailViewController: StudentDetailViewController = {
        return StudentDetailViewController()
    }()
    
    
    lazy var settingsViewController: SettingsViewController = {
        return SettingsViewController()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreboardViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house.fill"), tag: 0)
               
        studentDetailViewController.tabBarItem = UITabBarItem(title: "Detail", image: UIImage(systemName: "calendar.and.person"), tag: 1)
               
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), tag: 2)
        
        viewControllers = [scoreboardViewController, studentDetailViewController, settingsViewController]
        
        selectedIndex = 0
    }
    
}

    



