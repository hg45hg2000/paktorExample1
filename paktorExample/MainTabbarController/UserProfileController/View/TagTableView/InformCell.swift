//
//  InformCell.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/24.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

enum InformCelltype{
    case text(Array<TextData>)
    case silder(Array<SilderData>)
    case defaultType
}

struct TextData {
    var leftText:String
    var rightText:String
    
    init(leftText:String,rightText:String) {
        self.leftText = leftText
        self.rightText = rightText
    }
}

struct SilderData{
    var value : Float
    
    init(value:Float) {
        self.value = value
    }
}

class InformCell: UITableViewCell {
  
    static let informcellid = "informcellid"
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var silderUI: UISlider!
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    open func changecellType(InformCelltype:InformCelltype , indexPath:NSIndexPath){
        
        self.leftLabel.isHidden = true
        self.rightLabel.isHidden = true
        self.silderUI.isHidden = true
        
        switch InformCelltype {
        case .text(let textArray):
            let textdata = textArray[indexPath.row]
            self.leftLabel.isHidden = textdata.leftText == ""
            self.leftLabel.text = textdata.leftText
            self.rightLabel.isHidden = textdata.rightText == ""
            self.rightLabel.text = textdata.rightText
        case .silder(let silderArray):
            let silderData = silderArray[indexPath.row]
            self.silderUI.isHidden = false
            self.silderUI.value = silderData.value
            break
            
        default:
            break
        }
    }
}
