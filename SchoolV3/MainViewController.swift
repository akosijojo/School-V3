//
//  MainViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 8/13/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit
import KYDrawerController

class MainCoordinator {
    
    func start(window: UIWindow?) {
        let mainViewController   = CustomTabBarController()
        let drawerViewController = MenuController()
        let drawerController     =  KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection.left, drawerWidth: 250)
        let navigationController = UINavigationController(
            rootViewController: mainViewController
        )
        navigationController.navigationBar.barTintColor = Config().colors.grayBackground
        navigationController.navigationBar.tintColor  = Config().colors.orangeBackground
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Config().colors.orangeBackground]
        
        drawerController.mainViewController = navigationController
        drawerController.drawerViewController = drawerViewController
        
        window?.rootViewController = drawerController
    }
    
    
}
