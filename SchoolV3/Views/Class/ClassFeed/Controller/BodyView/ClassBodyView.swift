//
//  Class Body View.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/24/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

protocol ClassBodyDelegate : class {
    func onSwipe(cell:ClassBodyCell, index: Int)
    func onScroll(cell: ClassBodyCell,scroll: scrolled)
    func onRefresh(cell: ClassBodyCell,scroll: scrolled)
    func onClickFeedOption(cell: ClassBodyCell)
}

class ClassBodyCell : BaseCell<[ClassBody]> , UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ClassFeedViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.index = indexPath.row
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.onSwipe(cell: self, index: index)
        self.scroll(index: index)
    }
    
    func scroll(index: Int ) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        log.info("DID SCROLL scrollViewWillBeginDragging ")
    }
    
    override var data: [ClassBody]! {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var index : Int = 0
    
    var scrollAt : Int = 0
    
    let cellId = "cellBody"
    
    var delegate : ClassBodyDelegate?
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.backgroundColor = .white
        view.isPagingEnabled = true
        view.bounces = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ClassFeedViewCell.self, forCellWithReuseIdentifier: cellId)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
}


extension ClassBodyCell : ClassFeedViewCellProtocol {
    func onClickFeedOption(cell: ClassFeedViewCell) {
        self.delegate?.onClickFeedOption(cell: self)
    }
    
    func onRefresh(cell: ClassFeedViewCell, scroll: scrolled) {
        log.info("SCROLLING ON REFRESH : \(scroll)")
        self.delegate?.onRefresh(cell: self, scroll: scroll)
    }
    
    func didScroll(cell: ClassFeedViewCell,scroll: scrolled) {
        self.delegate?.onScroll(cell: self, scroll: scroll)
    }
}
