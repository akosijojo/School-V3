//
//  FeedImages.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 8/16/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//

import UIKit

struct FeedImagesData {
    let img : String
}

class FeedImagesCell : BaseCell<FeedFileData>,UIScrollViewDelegate {
    
    override var data: FeedFileData! {
        didSet{
            self.img.loadImage(from: data.fileImg)
        }
    }
    
    var didTap : Bool = false
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 10.0
//        scroll.alwaysBounceVertical = false
//        scroll.alwaysBounceHorizontal = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    lazy var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.masksToBounds = true
        return img
    }()
    
    override func setUpView() {
        setupGestureRecognizer()
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self.frame.width)
            make.height.equalTo(self.frame.height)
        }

        scrollView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.width.equalTo(self.frame.width)
            make.height.equalTo(self.frame.height)
            make.bottom.equalTo(scrollView)
        }

    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(gestureRecognizer)

    }

    @objc func handleDoubleTap() {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scrollView.maximumZoomScale, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
            didTap = true
        } else {
            didTap = false
            scrollView.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = img.frame.size.height / scale
        zoomRect.size.width = img.frame.size.width / scale
        let newCenter = convert(center, from: img)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.img
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if !didTap {
            scrollView.setZoomScale(1, animated: true)
        }
    }

}
