//
//  ClassFeedViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

class ClassFeedViewController: UIViewController {
    
    let cellImageID = "cellImageID"
    let cellMenuID  = "cellMenuID"
    let cellBodyID  = "cellBodyID"
    
    
    let cellHeader  = "cellHeader"
    
    var data : [ClassUIData] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var scrollAtBodyAndMenu : Int = 0
    
    var bodyData : [ClassBody] =  [ClassBody(data: "DATA 1", isFocus: false),ClassBody(data: "DATA 2", isFocus: false),ClassBody(data: "DATA 3", isFocus: true)]

    
    var leftBarButton : UIBarButtonItem?
    var rightBarButton : UIBarButtonItem?
    
//    lazy var mainView : UIView  = {
//        let view = UIView()
//        view.backgroundColor = Config().colors.orangeBackground
//        view.isUserInteractionEnabled = true
//        return view
//    }()
    
    lazy var collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.backgroundColor = Config().colors.lightGraybackground
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
//        view.bounces = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Config().colors.whiteBackground
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.register(ClassImageCell.self, forCellWithReuseIdentifier: cellImageID)
//        collectionView.register(ClassMenuCell.self, forCellWithReuseIdentifier: cellMenuID)
        collectionView.register(ClassBodyCell.self, forCellWithReuseIdentifier: cellBodyID)
        
        
        collectionView.register(ClassHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeader)
        
    }
    
    func setUpData() {
//        ClassUIData(cell: 2, height: 60),
        data = [ClassUIData(cell: 3, height: collectionView.frame.height)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpView()
        setUpData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpNavigationView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.title = ""
    }
    
    private func setUpNavigationView() {
        self.title = "Class Feed"
        let navBar = navigationController?.navigationBar
        leftBarButton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), landscapeImagePhone: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonAction))
        
        rightBarButton = UIBarButtonItem(image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), landscapeImagePhone: UIImage(named: "post"), style: .plain, target: self, action: #selector(showClass))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(2)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
        
    }
    
    @objc func showClass() {
        self.navigationController?.pushViewController(ClassFeedSoloViewController(), animated: true)
    }
    
    deinit {
        log.info("Deinit View : \(self)")
    }
}

extension ClassFeedViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellBodyID, for: indexPath) as? ClassBodyCell else {
            return UICollectionViewCell()
        }
        cell.data = self.bodyData
        cell.scroll(index: scrollAtBodyAndMenu)
        cell.delegate = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: self.view.frame.width, height: collectionView.frame.height - 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellHeader, for: indexPath) as? ClassHeaderCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = UIImage(named: "oa")
            cell.labelView.label.text = "YOURE CLASS NAME HERE adwaowjdo iawjdioa jwodjawo jdaoiwj daw"
            cell.delegate = self
            cell.scroll(index: scrollAtBodyAndMenu)
            cell.scrollAt = self.scrollAtBodyAndMenu
            return cell
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 260)
    }

}

extension ClassFeedViewController : ClassMenuDelegate , ClassBodyDelegate,ClassHeaderDelegate{
    // left and right swipe
    func onSwipe(cell: ClassBodyCell, index: Int) {
        if let cellHeaderMenu = self.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? ClassHeaderCell  {
            cellHeaderMenu.scrollAt = index
            cellHeaderMenu.collectionView.reloadData()
        }
        
        self.scrollAtBodyAndMenu = index
        
    }
    // on cell scroll
    func onScroll(cell: ClassBodyCell,scroll: scrolled) {
       
        switch scroll {
        case .top:
//            log.info(" SCROLLING UP AND DOWN : \(scroll)")
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        case .bottom:
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
        default:
            log.info(" SCROLLING UP AND DOWN : \(scroll)")
        }
    }
    
    func onRefresh(cell: ClassBodyCell, scroll: scrolled) {
         log.info(" SCROLLING UP AND DOWN : REFRESH \(scroll)")
    }
    
    // click feed option
    func onClickFeedOption(cell: ClassBodyCell) {
        let alert = UIAlertController(title: "", message: "Option", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertAction.Style.default, handler: { (editAct) in
            log.info("EDITING POST ")
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { (delAct) in
            log.info("DELETING POST ")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // menu clicked
    func onClick(cell: ClassMenuCell, index: Int) {
        if let cell =  self.collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as? ClassBodyCell {
            cell.scroll(index: index)
        }
        if let cell =  self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ClassMenuCell {
            cell.scrollAt = index
            cell.collectionView.reloadData()
        }
        self.scrollAtBodyAndMenu = index
    }
    
    func onClick(cell: ClassHeaderCell, index: Int) {
        
        if let cell =  self.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? ClassBodyCell {
            cell.scroll(index: index)
        }
    
        if let cellHeaderMenu = self.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? ClassHeaderCell  {
            cellHeaderMenu.scrollAt = index
            cellHeaderMenu.collectionView.reloadData()
        }
        
        self.scrollAtBodyAndMenu = index
    }

}





// actions on body when clicked//
// on scroll on top show header//
// dynamic body
// posting image//
// links
// video
// 



