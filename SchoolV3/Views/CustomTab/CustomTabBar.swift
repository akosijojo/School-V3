//
//  CustomTabBar.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class CustomTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = FeedViewController()
        let v1 = UINavigationController(rootViewController: vc1)
        let tb1:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "home_filled")?.withRenderingMode(.alwaysTemplate))
        v1.tabBarItem = tb1
        v1.interactivePopGestureRecognizer?.isEnabled = true
        v1.tabBarItem.title = ""
        
        let vc2 = ClassViewController()
        let v2 = UINavigationController(rootViewController: vc2)
        let tb2:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "class")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "class_filled")?.withRenderingMode(.alwaysTemplate))
        v2.tabBarItem = tb2
        v2.interactivePopGestureRecognizer?.isEnabled = true
        v2.tabBarItem.title = ""
        
        let vc3 = NotificationViewController()
        let v3 = UINavigationController(rootViewController: vc3)
        let tb3:UITabBarItem = UITabBarItem(title: " ", image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "star_filled")?.withRenderingMode(.alwaysTemplate))
        v3.tabBarItem = tb3
        v3.interactivePopGestureRecognizer?.isEnabled = true
        v3.tabBarItem.title = ""
        
        viewControllers = [v1,v2,v3]
        tabBar.barTintColor = Config().colors.grayBackground
        tabBar.tintColor = Config().colors.orangeBackground
        
        
    }
    
    
}
