//
//  FeedViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit
import KYDrawerController

class FeedViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FeedPostCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = Config().colors.whiteBackground
        cell.data = data[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let imageHeight = data[indexPath.row].type != nil ? ( data[indexPath.row].type == .image ? self.collectionView.frame.width : 100) : 0
        let actionHeight : CGFloat = 40
        let userViewHeight : CGFloat = 60
        let paddingViewHeight : CGFloat = 20 + 10 // 5 + 5 space on image // 10 top 10 bottom
        let postViewHeight : CGFloat = 40
        return CGSize(width: width, height: paddingViewHeight + postViewHeight + imageHeight + actionHeight + userViewHeight)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
//    }
//
    let cellId = "CellFeed"
    
    var data: [FeedData]! {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.backgroundColor = Config().colors.lightGraybackground
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Config().colors.whiteBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedPostCell.self, forCellWithReuseIdentifier: cellId)
       
    }
    
    override func viewDidLayoutSubviews() {
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.title = "Home"
       setUpNavigationBar()
        setUpData()
    }
    
    func setUpNavigationBar() {
        let navBar = navigationController?.navigationBar
        self.tabBarController?.navigationItem.title = "Home"
        
        let leftBar =  UIBarButtonItem(image: UIImage(named: "menu_bar")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showMenu))
        leftBar.tintColor = Config().colors.navButtonColors
        
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBar
        
        let rightBar =  UIBarButtonItem(image: UIImage(named: "post")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(gotoPosting))
        rightBar.tintColor = Config().colors.navButtonColors
        
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBar
        
    }
    
    @objc func showMenu() {
        if let drawerController = UIApplication.shared.keyWindow?.rootViewController as? KYDrawerController {
            drawerController.view.endEditing(true)
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    @objc func gotoPosting() {
        log.info("POSTING ")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    func setUpView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(-40)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func setUpData() {
        let images = [FeedImagesData(img: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg"),FeedImagesData(img: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg"),FeedImagesData(img: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg")]
        
        let file  = [FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "FILE TYPE",fileImg: "https://res.cloudinary.com/sfp/image/upload/q_60/cste/b06b7885-2afa-446c-bb7e-f44f897b3b60.jpeg"),
            FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "FILE TYPE",fileImg: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg"),
            FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "FILE TYPE",fileImg: "https://dw9to29mmj727.cloudfront.net/misc/newsletter-naruto3.png")]
        data  = [
            FeedData(user: "Mojow Jowjow", userImg : "https://res.cloudinary.com/sfp/image/upload/q_60/cste/b06b7885-2afa-446c-bb7e-f44f897b3b60.jpeg",file: file,post : "I love this scenery",type: .file),
            FeedData(user: "Mojow Jowjow", userImg : nil, file: file,post : "I love this scenery",type: .image),
            FeedData(user: "Mojow Jowjow", userImg : "https://res.cloudinary.com/sfp/image/upload/q_60/cste/b06b7885-2afa-446c-bb7e-f44f897b3b60.jpeg", file: file,post : "I love this scenery",type: .file ),
            FeedData(user: "Mojow Jowjow", userImg : nil, file: file,post : "I love this scenery",type: .image),
            FeedData(user: "Mojow Jowjow", userImg : "https://dw9to29mmj727.cloudfront.net/misc/newsletter-naruto3.png", file: nil,post : "I love this scenery",type: nil),
            FeedData(user: "Mojow Jowjow", userImg : "https://dw9to29mmj727.cloudfront.net/misc/newsletter-naruto3.png",file: nil,post : "I love this scenery",type: nil)
        ]
    }
    
}

extension FeedViewController : FeedPostCellProtocol {
    func onClickOption(cell: FeedPostCell) {
        
    }
    
}
