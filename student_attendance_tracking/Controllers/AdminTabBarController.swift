

import UIKit

class AdminTabBarController: UITabBarController {
    
    // MARK: - Properties
    lazy var scoreboardViewController: ScoreboardViewController = {
        return ScoreboardViewController()
    }()

    lazy var logAbsenceViewController: LogAbsenceViewController = {
        return LogAbsenceViewController()
    }()

    lazy var settingsViewController: SettingsViewController = {
        return SettingsViewController()
    }()
    
    lazy var studentDetailTableViewController : StudentDetailTableViewController = {
        return StudentDetailTableViewController()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        scoreboardViewController.tabBarItem = UITabBarItem(title: "Scoreboard", image: UIImage(systemName: "person.3.fill"), tag: 0)
               
        logAbsenceViewController.tabBarItem = UITabBarItem(title: "Absence Logging", image: UIImage(systemName: "person.badge.shield.checkmark.fill"), tag: 1)
        
        studentDetailTableViewController.tabBarItem = UITabBarItem(title: "Detail", image: UIImage(systemName: "calendar.and.person"), tag: 2)
               
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), tag: 3)
        
        viewControllers = [scoreboardViewController, logAbsenceViewController,studentDetailTableViewController, settingsViewController]
        
        selectedIndex = 0
    }
    
    func setupUI(){
        self.title = "Admin"
    }
}

    



