//
//  Class Image View.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class ClassImageCell : UICollectionViewCell {
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        mainView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView)
            make.leading.equalTo(mainView)
            make.trailing.equalTo(mainView)
            make.bottom.equalTo(mainView)
        }
        
        addSubview(labelView)
        labelView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self).offset(2)
            make.height.equalTo(60)
        }
        
    }
    
}

