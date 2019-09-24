//
//  ClassFeedPostCell.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

protocol FeedPostCellProtocol : class {
    func onClickOption(cell:FeedPostCell)
}

class FeedPostCell: BaseCell<FeedData> ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    var delegate :FeedPostCellProtocol?
    
    var indexPath : Int = 0
    
    var cellImagesId = "Cell Images"
    var cellFileId = "Cell File"
    
    var fileType : fileType? = nil
    
    override var data: FeedData! {
        didSet{
            self.userView.userName.text = data.user
            self.userView.userLabel.text = "an hour ago"
            self.postView.text = data.post
            
            if let userImg = data.userImg {
                self.userView.userImage.downloaded(from: userImg)
            }else {
                self.userView.userImage.image = UIImage(named: "user_logo")?.withRenderingMode(.alwaysTemplate)
            }
            
            self.fileType = data.type
            log.info("RELOAD HAHAHA : \(data.type)")
            switch data.type {
            case .image?:
                    self.fileCollectionView.register(FeedImagesCell.self, forCellWithReuseIdentifier: cellImagesId)
                    self.postWithImageView(show: true, type: .image)
                    self.pager.numberOfPages = data.file?.count ?? 0
            case .file?:
//                    self.fileCollectionView.register(FeedFileCell.self, forCellWithReuseIdentifier: cellFileId)
                    self.postWithImageView(show: true, type: .file)
                    self.fileView.fileImg.loadImage(from: data.file?[0].fileImg ?? "")
                    self.fileView.fileName.text = data.file?[0].fileName
//                    self.pager.numberOfPages = 0
                
                
            default:
                // hide image / file view
                self.fileCollectionView.delegate = nil
                self.fileCollectionView.dataSource = nil
                self.postWithImageView(show: false, type: nil)
            }
            
//            if data.img != nil {
//                self.imagePostView.delegate = self
//                self.imagePostView.dataSource = self
//                imagePostView.register(FeedImagesCell.self, forCellWithReuseIdentifier: cellId)
//                self.postWithImageView(show: true)
//                self.pager.numberOfPages = 2
//            }else {
//                self.imagePostView.delegate = nil
//                self.imagePostView.dataSource = nil
//                self.postWithImageView(show: false)
//            }
            
        }
    }
    
    lazy var mainView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var userView : UserView = {
        let view = UserView()
        return view
    }()
    
    lazy var fileView : FeedFileView = {
        let v = FeedFileView()
        v.backgroundColor = Config().colors.grayBackground
        v.layer.cornerRadius = 5
        return v
    }()
    
    lazy var postView : UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = Config().colors.textColorDark
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    lazy var fileCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.bounces = false
        return view
    }()
    
    lazy var pager : UIPageControl = {
        let view = UIPageControl()
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .gray
        view.currentPage = 0
        view.hidesForSinglePage = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var likeView : ActionView = {
        let view = ActionView()
        view.imageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        view.imageView.tintColor = Config().colors.orangeBackground
        view.label.text = "1 Like"
        return view
    }()
    
    lazy var commentView : ActionView = {
        let view = ActionView()
        view.imageView.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        view.imageView.tintColor = Config().colors.orangeBackground
        view.label.text = "1 Comment"
        return view
    }()
    
    
    override func setUpView() {
    
        self.fileCollectionView.delegate = self
        self.fileCollectionView.dataSource = self
        
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self)//.offset(20)
            make.trailing.equalTo(self)//.offset(-20)
            make.bottom.equalTo(self).offset(-10)
        }
        
        mainView.addSubview(userView)
        userView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView)
            make.leading.equalTo(mainView).offset(20)
            make.trailing.equalTo(mainView).offset(-20)
            make.height.equalTo(60)
        }
        
        mainView.addSubview(postView)
        postView.snp.makeConstraints { (make) in
            make.top.equalTo(userView.snp.bottom)
            make.leading.equalTo(mainView).offset(40)
            make.trailing.equalTo(mainView).offset(-40)
            make.height.equalTo(40)
        }
        
        mainView.addSubview(likeView)
        likeView.snp.makeConstraints { (make) in
            make.bottom.equalTo(mainView)
            make.leading.equalTo(mainView).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        mainView.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(mainView)
            make.leading.equalTo(likeView.snp.trailing).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        let onClickOption = UITapGestureRecognizer(target: self, action: #selector(onClickOptionAction))
        userView.option.addGestureRecognizer(onClickOption)
        
        
    }
    
    @objc func onClickOptionAction() {
        self.delegate?.onClickOption(cell: self)
    }
    
    func postWithImageView(show: Bool,type: fileType?) {
        if show {
            log.info("FILE TYPE DATA : \(type)")
            switch type {
            case .image?:
                mainView.addSubview(fileCollectionView)
                fileCollectionView.backgroundColor = Config().colors.lightGraybackground
                fileCollectionView.snp.makeConstraints { (make) in
                    make.top.equalTo(postView.snp.bottom).offset(5)
                    make.leading.equalTo(mainView)//.offset(20)
                    make.trailing.equalTo(mainView)//.offset(-20)
                    make.height.equalTo(self.frame.width) // plus 5 for space on bottom
                }
                
                mainView.addSubview(pager)
                pager.snp.makeConstraints { (make) in
                    make.bottom.equalTo(fileCollectionView).offset(10)
                    make.leading.equalTo(mainView)//.offset(20)
                    make.trailing.equalTo(mainView)//.offset(-20)
                    make.height.equalTo(40)
                }
            case .file?:
                mainView.addSubview(fileView)
                fileView.backgroundColor = .cyan
                fileView.snp.makeConstraints { (make) in
                    make.top.equalTo(postView.snp.bottom).offset(10)
                    make.leading.equalTo(mainView).offset(10)//.offset(20)
                    make.trailing.equalTo(mainView).offset(-10)//.offset(-20)
                    make.height.equalTo(100) // plus 5 for space on bottom
                }
            default:
                fileView.removeFromSuperview()
                pager.removeFromSuperview()
                fileCollectionView.removeFromSuperview()
            }
        }else {
            fileView.removeFromSuperview()
            pager.removeFromSuperview()
            fileCollectionView.removeFromSuperview()
        }
    
    }
    
    // collectionVIew
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch fileType {
//        case .image?:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImagesId, for: indexPath) as? FeedImagesCell else {
                return UICollectionViewCell()
            }
            
            cell.data  = data.file?[indexPath.row]
            
            return cell
//        case .file?:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellFileId, for: indexPath) as? FeedFileCell else {
//                return UICollectionViewCell()
//            }
//
//            cell.data = data.file?[0]
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch fileType {
//        case .image?:
            return CGSize(width: self.fileCollectionView.frame.width, height: self.fileCollectionView.frame.height)
//        case .file?:
//            return CGSize(width: self.fileCollectionView.frame.width, height: 100)
//        default:
//             return CGSize(width: 0, height: 0)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch fileType {
//        case .image?:
            return data.file?.count ?? 0
//        case .file?:
//            return 1
//        default:
//            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        switch fileType {
        case .image?:
            self.fileCollectionView.scrollToItem(at: IndexPath(row: indexPath, section: 0), at: .centeredHorizontally, animated: true)
            self.pager.currentPage = indexPath
       
        default:
            log.info("Scroll DECELERATING")
        }
    }
    
    
}




class FeedFileView : UIView  {
//    lazy var fileView : UIView = {
//        let view = UIView()
//        //        view.layer.borderColor = Config().colors.grayBackground.cgColor
//        //        view.layer.borderWidth = 1
//        view.backgroundColor = Config().colors.grayBackground
//        view.layer.cornerRadius = 5
//        return view
//    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(fileImg)
        fileImg.backgroundColor = .green
        fileImg.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.top.equalTo(self)
            make.width.equalTo(self.frame.height - 40)
            make.bottom.equalTo(self)
        }
        
        addSubview(fileName)
        fileName.backgroundColor = .red
        snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(fileImg.snp.trailing).offset(10)
            make.trailing.equalTo(self)
        }
        
        
    }
    
}
