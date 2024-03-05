//
//  TabBarController.swift
//  arlnc-iOS
//
//  Created by resoul on 05.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        delegate = self
        
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
        homeController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
        
        let profileController = UINavigationController(rootViewController: ProfileController())
        profileController.tabBarItem.image = UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
        profileController.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.label)
        
        viewControllers = [
            homeController,
            profileController
        ]
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
