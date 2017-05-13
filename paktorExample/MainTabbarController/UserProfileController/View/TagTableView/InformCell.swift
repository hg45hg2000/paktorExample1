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

class SilderData{
    
    var value : Float{
        didSet{
            print("slider value change \(value)")
        }
    }
    
    
    init(value:Float) {
        self.value = value
    }
    

}

class InformCell: UITableViewCell {
  
    static let informcellid = "informcellid"
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var silderUI: UISlider!
    

    var dataIndex : Int  = 0
    
    var informCellType = InformCelltype.defaultType
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.silderUI.isContinuous = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    open func changecellType(InformCelltype:InformCelltype , indexPath:IndexPath){
        
        self.leftLabel.isHidden = true
        self.rightLabel.isHidden = true
        self.silderUI.isHidden = true
        self.dataIndex = indexPath.row
        self.informCellType = InformCelltype
        switch InformCelltype {
        case .text(let textArray):
            let textdata = textArray[dataIndex]
            self.leftLabel.isHidden = textdata.leftText == ""
            self.leftLabel.text = textdata.leftText
            self.rightLabel.isHidden = textdata.rightText == ""
            self.rightLabel.text = textdata.rightText
            break
        case .silder(let silderArray):
            let sliderData = silderArray[dataIndex]
            self.silderUI.isHidden = false
            self.silderUI.value = sliderData.value
            self.silderUI.addTarget(self, action: #selector(InformCell.silderValueChange), for: .valueChanged)
            break
        default:
            break
        }
    }
     @objc private func silderValueChange(slider:UISlider){
        switch self.informCellType {
        case .silder(var sliderArray):
            sliderArray[dataIndex].value = slider.value
            break
        default:break
        }
    }
    
}
