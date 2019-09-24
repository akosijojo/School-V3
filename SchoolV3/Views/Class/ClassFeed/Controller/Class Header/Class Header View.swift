//
//  Class Header View.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

protocol ClassHeaderDelegate: class {
    func onClick(cell:ClassHeaderCell, index: Int)
}

class ClassHeaderCell : UICollectionViewCell , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ClassHeaderViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = menuData[indexPath.row]
        cell.labelView.imageView.tintColor = scrollAt == indexPath.row ? Config().colors.orangeBackground : Config().colors.whiteBackground
        cell.labelView.label.textColor = scrollAt == indexPath.row ? Config().colors.orangeBackground : Config().colors.whiteBackground
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(menuData.count)
        return CGSize(width: width, height: collectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onClick(cell: self, index: indexPath.row)
    }
    
    func scroll(index: Int ) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .top, animated: true)
    }
    
    var menuData : [ClassMenu] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var scrollAt : Int = 0
    
    var delegate : ClassHeaderDelegate?
    
    let cellId = "cellMenu"
    
    lazy var mainView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var labelView : ViewWithLabel = {
        let view = ViewWithLabel()
        view.backgroundColor = Config().colors.whiteBackground
        //        view.label.textColor = Config().colors.whiteBackground
        return view
    }()
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.backgroundColor = .white
        //        view.isPagingEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ClassHeaderViewCell.self, forCellWithReuseIdentifier: cellId)
        setUpView()
        setUpData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData() {
        menuData = [ClassMenu(img: "menu_newsfeed",menu: "ClassFeed"),ClassMenu(img: "menu_calendar",menu: "Calendar"),ClassMenu(img: "menu_ellipses",menu: "More")]
    }
    
    func setUpView() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        mainView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.leading.equalTo(mainView)
            make.trailing.equalTo(mainView)
            make.bottom.equalTo(mainView)
        }
        
        mainView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView)
            make.leading.equalTo(mainView)
            make.trailing.equalTo(mainView)
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        mainView.addSubview(labelView)
        labelView.snp.makeConstraints { (make) in
            make.leading.equalTo(mainView)
            make.trailing.equalTo(mainView)
            make.bottom.equalTo(collectionView.snp.top)
            make.height.equalTo(60)
        }
        
    }
    
}

class ClassHeaderViewCell : UICollectionViewCell {
    
    var data : ClassMenu? {
        didSet{
            self.labelView.imageView.image = UIImage(named: data?.img ?? "")?.withRenderingMode(.alwaysTemplate)
            self.labelView.label.text = data?.menu
        }
    }
    
    lazy var mainView : UIView = {
        let view = UIView()
        view.backgroundColor = Config().colors.grayBackground
        return view
    }()
    
    lazy var labelView : ViewWithImageAndLabel = {
        let view = ViewWithImageAndLabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.backgroundColor = Config().colors.lightGraybackground
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self).offset(-5)
        }
        
        mainView.addSubview(labelView)
        labelView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView).offset(5)
            make.leading.equalTo(mainView).offset(10)
            make.trailing.equalTo(mainView).offset(-10)
            make.bottom.equalTo(mainView).offset(-5)
        }
    }
    
}

