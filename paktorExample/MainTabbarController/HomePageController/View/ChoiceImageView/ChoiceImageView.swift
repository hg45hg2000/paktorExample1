//
//  ChoiceImageView.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/21.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

enum ChoiceImageViewType{
    case Check
    case Cross
    case Blank
}



class ChoiceImageView: UIImageView {

    internal func changeType(ImageViewType:ChoiceImageViewType){
        switch ImageViewType {
        case .Check: self.image = #imageLiteral(resourceName: "Checkmark-50")
        case .Cross: self.image = #imageLiteral(resourceName: "Delete-50")
        case .Blank: self.image = UIImage(named: "")
        }
    }

}
