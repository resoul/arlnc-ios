//
//  MainTabBarController.swift
//  arlnc-iOS
//
//  Created by resoul on 03.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem.image = UIImage(named: "house")
        homeController.tabBarItem.selectedImage = UIImage(named: "house.fill")
        
        let searchController = UINavigationController(rootViewController: SearchController())
        searchController.tabBarItem.image = UIImage(named: "house")
        searchController.tabBarItem.selectedImage = UIImage(named: "house.fill")
        
        viewControllers = [
            homeController,
            searchController
        ]
    }
}
