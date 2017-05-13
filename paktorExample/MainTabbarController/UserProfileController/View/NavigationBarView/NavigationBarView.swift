//
//  NavigationBarView.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/5/4.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

class NavigationBarView: UIView {

    var button :UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI(){
        self.backgroundColor = UIColor(red: 121/255.0, green: 193/255.0, blue: 203/255.0, alpha: 1.0)
        self.alpha = 0.0
        
    }
    
    open func addButton(image:UIImage,target: Any?,action:Selector){
        button = UIButton(type: .custom)
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: UIControlState())
        button.tintColor = UIColor.white
        button.addTarget(target, action: action, for: .touchUpInside)
        button.frame = CGRect(x: 10, y: 20, width: 44, height: 44)
        self.addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
