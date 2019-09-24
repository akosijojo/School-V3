//
//  User View.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class UserView : UIView {
    
    lazy var mainView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var userImage : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "user_logo")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = Config().colors.orangeBackground
        return view
    }()
    
    lazy var userName : UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor = Config().colors.textColorDark
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    lazy var userLabel : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = Config().colors.textColorLight
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    lazy var option : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "more")?.withRenderingMode(.alwaysTemplate)
        view.layer.masksToBounds = true
        view.tintColor = Config().colors.orangeBackground
        view.isUserInteractionEnabled = true
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
        
        mainView.addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.width.equalTo(60)
            make.bottom.equalTo(self)
        }
        userImage.layer.cornerRadius = 60 / 2
        
        mainView.addSubview(option)
        option.snp.makeConstraints { (make) in
            make.trailing.equalTo(self)
            make.width.equalTo(20)
            make.centerY.equalTo(self)
            make.height.equalTo(20)
        }
        
        mainView.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.trailing.equalTo(option.snp.leading).offset(-10)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        
        mainView.addSubview(userLabel)
        userLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom)
            make.leading.equalTo(userImage.snp.trailing).offset(10)
            make.trailing.equalTo(option.snp.leading).offset(-10)
            make.bottom.equalTo(self)
        }
        
        
    }
}



class ActionView : UIView {
    
    lazy var mainView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var label : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = Config().colors.textColorDark
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
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
            make.centerY.equalTo(self)
            make.leading.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        mainView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
       
        
    }
}

