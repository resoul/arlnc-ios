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
        view.backgroundColor = .systemBackground
        delegate = self
        
        viewControllers = [
            createController(icon: "house", activeIcon: "house.fill", HomeController()),
            createController(icon: "magnifyingglass.circle", activeIcon: "magnifyingglass.circle.fill", SearchController()),
            createController(icon: "play.tv", activeIcon: "play.tv.fill", ProfileController()),
            createController(icon: "bag", activeIcon: "bag.fill", ProfileController()),
            createController(icon: "person.crop.circle", activeIcon: "person.crop.circle.fill", ProfileController())
        ]
    }
    
    func createController(icon: String, activeIcon: String? = nil, _ rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.tabBarItem.image = setIcon(name: icon)
        
        guard let activeIcon = activeIcon else {
            return controller
        }
        
        controller.tabBarItem.selectedImage = setIcon(name: activeIcon)
        
        return controller
    }
    
    func setIcon(name: String) -> UIImage {
        guard let image = UIImage(systemName: name) else {
            return UIImage()
        }
        
        return image.withRenderingMode(.alwaysOriginal).withTintColor(.label)
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
