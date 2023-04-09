//
//  ViewController.swift
//  Navigation
//
//  Created by n p on 04.04.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .init(red: 0.00, green: 0.50, blue: 1.00, alpha: 0.70)
        tabBar.unselectedItemTintColor = .systemGray2
//        tabBar.layer.borderColor = .init(gray: 0.7, alpha: 0.9)
//        tabBar.layer.borderWidth = 1
//        tabBar.layer.masksToBounds = true
        
        let feedViewController = FeedViewController()
        
        let feedNavigationViewController = UINavigationController(rootViewController: feedViewController)
        feedNavigationViewController.tabBarItem.title = "Feed"
        feedNavigationViewController.tabBarItem.image = UIImage(systemName: "scroll.fill")
        
        let profileViewController = ProfileViewController()
        
        let profileNavigationViewController = UINavigationController(rootViewController: profileViewController)
        profileNavigationViewController.tabBarItem.title = "Profile"
        profileNavigationViewController.tabBarItem.image = UIImage(systemName: "person.circle.fill")

        viewControllers = [feedNavigationViewController, profileNavigationViewController]
    }
}

