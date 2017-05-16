//
//  TableViewCell.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/5/16.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate : class {
    func TableViewCellSelectIndexPath(indexPath:IndexPath)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    static let TableViewCellID = "TableViewCellID"
    
    var informCellDate  =  InformCelltype.defaultType
    
    weak var delegate : TableViewCellDelegate? = nil
    
    var sectionIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    open func configureCell(CellType:InformCelltype){
        setTableViewCell()
        DispatchQueue.main.async {
        self.informCellDate = CellType
        self.tableView.reloadData()
        }
    }

    private func setTableViewCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InformCell", bundle: nil), forCellReuseIdentifier: InformCell.informcellid)
    }
    
}
extension TableViewCell:UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch self.informCellDate {
        case .text (let textarray):
            return textarray.count
        case .silder(let silderAarray):
            return silderAarray.count
        default:break
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: InformCell.informcellid)as!InformCell
        cell.changecellType(InformCelltype: self.informCellDate, indexPath:indexPath )
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.TableViewCellSelectIndexPath(indexPath: IndexPath(row: indexPath.row, section: self.sectionIndex))
        
    }
    
}
