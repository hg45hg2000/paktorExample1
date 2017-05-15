//
//  StretchHeader.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/23.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

open class StretchHeaderOptions {
    
    open var position : HeaderPosition = .fullScreenTop
    
    public enum HeaderPosition {
        case fullScreenTop
        case underNavigationBar
    }
    public enum AddSubviewType{
        case nope
        case buttonView
    }
    
    public init() {}
}

open class StretchHeader: UIView {
    
    open var imageView : UIImageView = {
        let  imageView = UIImageView()
            imageView.backgroundColor = UIColor.orange
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let buttonViewHeight : CGFloat = 100
    lazy var buttonView : UIView = {
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.white
        return buttonView
    }()
    
    lazy var infoLabel : UILabel = {
        let infoLabel = UILabel()
        infoLabel.backgroundColor = UIColor.purple
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.layer.masksToBounds = true
        return infoLabel
    }()
    

    
    fileprivate var contentSize = CGSize.zero
    fileprivate var topInset : CGFloat = 0
    fileprivate var options: StretchHeaderOptions!
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    fileprivate func commonInit() {
        
        addSubview(imageView)
        
    }
    
    // MARK: Public
    open func stretchHeaderSize(headerSize: CGSize, imageSize: CGSize, controller: UIViewController, options: StretchHeaderOptions) {
        
        let status_height = UIApplication.shared.statusBarFrame.height
        let navi_height = controller.navigationController?.navigationBar.frame.size.height ?? 44
        
        self.options = options
        
        if options.position == StretchHeaderOptions.HeaderPosition.fullScreenTop{
            controller.automaticallyAdjustsScrollViewInsets = false
        }
        
        if options.position == StretchHeaderOptions.HeaderPosition.underNavigationBar {
            if let translucent = controller.navigationController?.navigationBar.isTranslucent {
                if translucent {
                    topInset += status_height + navi_height
                }
            }
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        contentSize = imageSize
        self.frame = CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height)
        addButton(frameSize: headerSize)
    }
    
    open func setupInfoViewText(text: String){
        infoLabel.text = text
    }
    
    open func updateScrollViewOffset(_ scrollView: UIScrollView) {
        
        var scrollOffset : CGFloat = scrollView.contentOffset.y
        scrollOffset += topInset
        
        //  minus negative number become positive  
        if scrollOffset < 0 {
            imageView.frame = CGRect(x: scrollOffset ,y: scrollOffset, width: contentSize.width - (scrollOffset * 2) , height: contentSize.height - scrollOffset);
            buttonView.frame = CGRect(x: 0 , y: contentSize.height - buttonViewHeight + scrollOffset, width: contentSize.width, height: buttonViewHeight)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height);
            buttonView.frame = CGRect(x: 0 , y: contentSize.height - buttonViewHeight, width: contentSize.width, height: buttonViewHeight)
        }
    }
    private func addButton(frameSize: CGSize){
        
        addSubview(buttonView)
        buttonView.frame = CGRect(x:0 , y: frameSize.height - buttonViewHeight, width: frameSize.width, height: buttonViewHeight)
        buttonView.backgroundColor = UIColor.clear
        
        infoLabel.frame = CGRect(x: 0, y: 0, width: buttonView.frame.width, height: buttonView.frame.height/2)
        infoLabel.layer.cornerRadius = infoLabel.frame.size.height/2
        
        buttonView.addSubview(infoLabel)
        
        let buttontitle = ["PERVIEW","REMOVE"]
        let buttonWidth = buttonView.frame.width/2
        let buttonHeight :CGFloat = buttonView.frame.height/2
        
        for i in 0...1 {
            let button  = UIButton(type: .custom)
            button.frame = CGRect(x: (CGFloat(i) * buttonWidth), y: buttonHeight, width: buttonWidth, height: buttonHeight)
            button.setTitle(buttontitle[i], for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.backgroundColor = UIColor.white
            button.alpha = 0.5
            buttonView.addSubview(button)
        }
        
    }
}

