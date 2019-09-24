//
//  ClassFeedCell.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

enum scrolled {
    case top
    case bottom
}

protocol ClassFeedViewCellProtocol : class {
    func didScroll(cell: ClassFeedViewCell,scroll: scrolled)
    func onRefresh(cell: ClassFeedViewCell,scroll: scrolled)
    func onClickFeedOption(cell: ClassFeedViewCell)
}

class ClassFeedViewCell : UICollectionViewCell , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? FeedPostCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.backgroundColor = Config().colors.whiteBackground
        cell.data = data[indexPath.row]
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
  
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
//        if scrollView.contentOffset.y <= 0 {
//            log.info("SCROLLING ON TOP")
//        }
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > 0 && !didGotoTop {
            didGotoTop = true
            self.delegate?.didScroll(cell: self, scroll: .bottom)
        }else if scrollView.contentOffset.y < 0 && didGotoTop {
            didGotoTop = false
            self.delegate?.didScroll(cell: self, scroll: .top)
        }else {
            
        }
    }
   
    var data : [FeedData] = [] {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var didGotoTop : Bool = false
    
    let cellId = "cellID"
    
    var delegate : ClassFeedViewCellProtocol?
    
    
    var refresherTop : UIRefreshControl?
    var refresherBottom : UIRefreshControl?
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.backgroundColor = Config().colors.lightGraybackground
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedPostCell.self, forCellWithReuseIdentifier: cellId)
        
        setUpView()
        setUpData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData() {
        let file = [FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "File Type", fileImg: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg"),
                    FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "File Type", fileImg: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg"),
                    FeedFileData(file: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg", fileName: "File Type", fileImg: "https://image.freepik.com/free-photo/blue-mountains-famous-tourism-scenery-lijiang_1417-1143.jpg")]
        data  = [
            FeedData(user: "Mojow Jowjow", userImg : "https://res.cloudinary.com/sfp/image/upload/q_60/cste/b06b7885-2afa-446c-bb7e-f44f897b3b60.jpeg",file: file,post : "I love this scenery",type: .file),
            FeedData(user: "Mojow Jowjow", userImg : nil,file: file,post : "I love this scenery",type: .image),
            FeedData(user: "Mojow Jowjow", userImg : "https://res.cloudinary.com/sfp/image/upload/q_60/cste/b06b7885-2afa-446c-bb7e-f44f897b3b60.jpeg",file: file,post : "I love this scenery",type: .image),
            FeedData(user: "Mojow Jowjow", userImg : nil, file: file,post : "I love this scenery",type: .image),
            FeedData(user: "Mojow Jowjow", userImg : "https://dw9to29mmj727.cloudfront.net/misc/newsletter-naruto3.png", file: nil,post : "I love this scenery",type: nil),
            FeedData(user: "Mojow Jowjow", userImg : "https://dw9to29mmj727.cloudfront.net/misc/newsletter-naruto3.png", file: nil,post : "I love this scenery",type: nil)
        ]
    }
    
    func setUpView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    @objc func refreshTopAction() {
        log.info("REFRESHING TOP")
        self.delegate?.onRefresh(cell: self, scroll: .top)
    
    }
    
    @objc func refreshBottomAction() {
        log.info("REFRESHING BOTTOM")
        self.delegate?.onRefresh(cell: self, scroll: .bottom)
      
    }
    
}


extension ClassFeedViewCell : FeedPostCellProtocol {
    func onClickOption(cell: FeedPostCell) {
        self.delegate?.onClickFeedOption(cell: self)
    }
}
