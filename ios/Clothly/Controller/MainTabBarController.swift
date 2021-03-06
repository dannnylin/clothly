//
//  MainTabBarController.swift
//  Clothly
//
//  Created by Danny on 3/24/18.
//  Copyright © 2018 Stanley Zeng. All rights reserved.
//

import Foundation
import UIKit

enum AppStatus {
    case donor
    case org
}

class MainTabBarController: UITabBarController {
    var status: AppStatus!
    var homeViewController: UIViewController!
    var pendingViewController: PendingViewController!
    var historyViewController: PendingViewController!
    var settingsViewController: SettingViewController!
    
    var navigationControllers: [UINavigationController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        setupNavigationControllers()
        
        self.viewControllers = navigationControllers
        self.tabBar.tintColor = UIColor.blue
    }
    
    func createViewControllers() {
        homeViewController = OrganizationPickViewController.create()
        homeViewController.view.backgroundColor = UIColor.white
        homeViewController.navigationItem.title = "DONATE"
        homeViewController.tabBarItem.image = UIImage(named: "donate")
        homeViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: nil, action: nil)
        
        pendingViewController = PendingViewController.create()
        pendingViewController.type = .pending
        pendingViewController.tabBarItem.image = UIImage(named: "pending")
        pendingViewController.view.backgroundColor = UIColor.white
        pendingViewController.navigationItem.title = "PENDING"
        
        historyViewController = PendingViewController.create()
        historyViewController.type = .history
        historyViewController.tabBarItem.image = UIImage(named: "history")
        historyViewController.view.backgroundColor = UIColor.white
        historyViewController.navigationItem.title = "HISTORY"
        
        settingsViewController = SettingViewController.create()
        settingsViewController.tabBarItem.image = UIImage(named: "settings")
        settingsViewController.view.backgroundColor = UIColor.white
        settingsViewController.navigationItem.title = "SETTINGS"
    }
    
    func setupNavigationControllers() {
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let pendingNavigationController = UINavigationController(rootViewController: pendingViewController)
        let historyNavigationController = UINavigationController(rootViewController: historyViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        homeNavigationController.tabBarItem.title = "DONATE"
        
        pendingNavigationController.tabBarItem.title = "PENDING"
        
        historyNavigationController.tabBarItem.title = "HISTORY"
        
        settingsNavigationController.tabBarItem.title = "SETTINGS"
        
        if status == .donor {
            navigationControllers = [homeNavigationController, pendingNavigationController, historyNavigationController, settingsNavigationController]
        } else {
            navigationControllers = [pendingNavigationController, historyNavigationController]
        }
    }
    
    class func create(status: AppStatus) -> MainTabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainTabBarController") as! MainTabBarController
        
        controller.status = status
        
        let _ = controller.view
        
        return controller
    }

}
