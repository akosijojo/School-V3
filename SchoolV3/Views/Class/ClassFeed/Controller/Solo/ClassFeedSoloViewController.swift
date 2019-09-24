//
//  ClassFeedSoloViewController.swift
//  SchoolV3
//
//  Created by Jojo Destreza on 7/23/19.
//  Copyright © 2019 Jojo Destreza. All rights reserved.
//


import UIKit

class ClassFeedSoloViewController: UIViewController , UITextViewDelegate{

    lazy var scrollView : UIScrollView  = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var mainView : UIView  = {
        let view = UIView()
        view.backgroundColor = Config().colors.orangeBackground
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var textView : UITextView  = {
        let view = UITextView()
        view.backgroundColor = Config().colors.orangeBackground
        view.text = "HAHAHHA"
        view.font = UIFont.systemFont(ofSize: 16)
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }()
    
    lazy var otherOptionsView : UIView  = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Config().colors.whiteBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpNavigationView()
        setUpView()
        textView.delegate = self
        log.info("PARENT VIEW : \(self.presentedViewController?.parent?.title)")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        mainView.isUserInteractionEnabled = true
        
        let tapText = UITapGestureRecognizer(target: self, action: #selector(tapTextAction))
        tapText.numberOfTapsRequired = 1
        mainView.addGestureRecognizer(tapText)
        
        
        let taptap = UITapGestureRecognizer(target: self, action: #selector(tapping))
        taptap.numberOfTapsRequired = 2
        mainView.addGestureRecognizer(taptap)
    
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.whenShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
//         Notification.Name.keyboardWillShowNotification
        notification.addObserver(self, selector: #selector(self.whenHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    
    @objc func whenShowKeyboard(_ notification : NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.view.layoutMarginsGuide.snp.bottom).offset(-keyboardHeight)
            }
            updateMainView(textView: self.textView.text)
        }
    }
    
    @objc func whenHideKeyboard(_ notification : NSNotification) {
        scrollView.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.view.layoutMarginsGuide.snp.bottom).offset(0)
        }
        updateMainView(textView: self.textView.text)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func tapping() {
        self.otherOptionsView.snp.updateConstraints { (make) in
            make.height.equalTo(self.otherOptionsView.frame.height == 100 ? 0 : 100)
        }
    }
    
    @objc func tapTextAction() {
        self.textView.becomeFirstResponder()
    }
    
    private func setUpNavigationView() {
        self.title = "Solo Feed"
    }
    
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .cyan
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
        
        scrollView.addSubview(mainView)
        mainView.backgroundColor = .red
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(80) // 20 + 20 + 40
        }
        
        mainView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView).offset(20)
            make.leading.equalTo(mainView).offset(20)
            make.trailing.equalTo(mainView).offset(-20)
            make.bottom.equalTo(mainView).offset(-20)
        }
        
        scrollView.addSubview(otherOptionsView)
        otherOptionsView.backgroundColor = .yellow
        otherOptionsView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView.snp.bottom).offset(10)
            make.leading.equalTo(mainView)
            make.trailing.equalTo(mainView)
            make.height.equalTo(0)
            make.bottom.equalTo(scrollView)
        }
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        updateMainView(textView: textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        log.info("shouldChangeTextIn : \(text.count) > \(textView.text.count) : \(range)")
        updateMainView(textView: self.textView.text)
        // pasting check to scroll to bottoom check mo to scrolling ng textview pag paste ng text
        if text.count > 1 {
            log.info("SCROLL TO BOTTOM OF TEXTVIEw : \(self.textView.text.count) == \(text.count)")
            let location = text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(range)
        }
 
        return true
    }
    
    func updateMainView(textView: String) {
        // 40 + 20
        let height = textView.height(withConstrainedWidth: view.frame.width - 60, font: UIFont.systemFont(ofSize: 16))
        log.info("CHANGING : \(height)")
        let viewHeight : CGFloat = scrollView.layoutMarginsGuide.layoutFrame.height - 40
        mainView.snp.updateConstraints { (make) in
            make.height.equalTo(height > 80 ? (height <= viewHeight ? height : viewHeight) : 80)
        }
    }
    
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
