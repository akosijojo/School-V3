//
//  ClassViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {
    
    lazy var mainView : UIView  = {
        let view = UIView()
        view.backgroundColor = Config().colors.orangeBackground
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = Config().colors.whiteBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpNavigationView()
        setUpView()
    }
    
    private func setUpNavigationView() {
//        self.title = "Class"
        let navBar = navigationController?.navigationBar
        self.tabBarController?.navigationItem.title = "Class"
        
        let rightBar =  UIBarButtonItem(image: UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(createClass))
        rightBar.tintColor = Config().colors.navButtonColors
        
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func createClass() {
        print("Create Class")
    }
    
    private func setUpView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(10)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(200)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showClass))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func showClass() {
        let navClassFeed = UINavigationController(rootViewController: ClassFeedViewController())
        navClassFeed.navigationBar.barTintColor = Config().colors.grayBackground
        navClassFeed.navigationBar.tintColor = Config().colors.whiteBackground
        navClassFeed.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Config().colors.orangeBackground]
        self.present(navClassFeed, animated: true, completion: nil)
    
    }
}

