//
//  FeddFileCell.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 8/19/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit



struct FeedFileData {
    let file : String
    let fileName : String
    let fileImg : String
}

class FeedFileCell : BaseCell<FeedFileData> {
    
    override var data: FeedFileData! {
        didSet{
            self.fileName.text = data.fileName
            self.fileImg.loadImage(from: data.fileImg)
        }
    }
    
    lazy var fileView : UIView = {
        let view = UIView()
//        view.layer.borderColor = Config().colors.grayBackground.cgColor
//        view.layer.borderWidth = 1
        view.backgroundColor = Config().colors.grayBackground
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var fileName : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var fileImg : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
    }()
    
    override func setUpView() {
        addSubview(fileView)
        fileView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        fileView.addSubview(fileImg)
        fileImg.snp.makeConstraints { (make) in
            make.leading.equalTo(fileView).offset(10)
            make.top.equalTo(fileView)
            make.width.equalTo(self.frame.height - 40)
            make.bottom.equalTo(fileView)
        }
        
        fileView.addSubview(fileName)
        fileName.snp.makeConstraints { (make) in
            make.top.equalTo(fileView)
            make.bottom.equalTo(fileView)
            make.leading.equalTo(fileImg.snp.trailing).offset(10)
            make.trailing.equalTo(fileView).offset(-5)
        }
        
        
    }
    
}
