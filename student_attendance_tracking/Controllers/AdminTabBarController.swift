//
//  MainTabBarControllerViewController.swift
//  InstaClonewithFireBase
//
//  Created by Okan Karaman on 18.10.2024.
//

import UIKit

class AdminTabBarController: UITabBarController {
    
    // MARK: - Properties
    lazy var scoreboardViewController: ScoreboardViewController = {
        return ScoreboardViewController()
    }()

    lazy var record_an_absenceViewController: Record_an_absenceViewController = {
        return Record_an_absenceViewController()
    }()

    lazy var settingsViewController: SettingsViewController = {
        return SettingsViewController()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        scoreboardViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "person.3.fill"), tag: 0)
               
        record_an_absenceViewController.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "person.badge.shield.checkmark.fill"), tag: 1)
               
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "rectangle.portrait.and.arrow.right.fill"), tag: 2)
        
        viewControllers = [scoreboardViewController, record_an_absenceViewController, settingsViewController]
        
        selectedIndex = 0
    }
    
    func setupUI(){
        self.title = "Admin"
        print("Admintabbarcontroller - setupUI")
    }
    
}

    



