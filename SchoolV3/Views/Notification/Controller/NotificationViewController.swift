//
//  NotificationViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = Config().colors.whiteBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.title = "Notification"
        let navBar = navigationController?.navigationBar
        self.tabBarController?.navigationItem.title = "Notification"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    
}

