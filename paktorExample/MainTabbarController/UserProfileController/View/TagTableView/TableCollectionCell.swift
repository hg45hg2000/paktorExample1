//
//  TagTableCell.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/24.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit


enum tabelCellType{
    case collectioView(CollectionCellType)
    case tableview(InformCelltype)
}
protocol TableCollectionCellDelegate : class {
    func TableCollectionCellSelectIndexPath(indexPath:IndexPath)
}


class TableCollectionCell: UITableViewCell {
    
    static let  TableCollectionCellID : String  = "TableCollectionCellid"
    

    var tagcell :TagViewCell?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sizingCell: TagCell?
    
    var collectionCellTypes  = CollectionCellType.defaultType

    
    weak var delegate : TableCollectionCellDelegate? = nil
    
    var sectionIndex : Int = 0
    
    open func configureCellData(CellType:CollectionCellType){
            setCollectionView()
            switch CellType {
            case .image(_):
                self.collectionView.setCollectionViewLayout(ImageFlowLayout(), animated: false)
            case .tag(_):
                self.collectionView.setCollectionViewLayout(TagFlowLayout(), animated: false)
            default: break
            }

            DispatchQueue.main.async {
                self.collectionCellTypes = CellType
                self.collectionView.reloadData()
            }
    }

    private func setCollectionView(){
            collectionView.register(TagViewCell.self, forCellWithReuseIdentifier: TagViewCell.tagViewCellID)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isHidden = false;
        
            let cellNib = UINib(nibName: "TagCell", bundle: nil)
            self.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
            self.collectionView.backgroundColor = UIColor.clear
            self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCell?
    }
}


extension TableCollectionCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        switch collectionCellTypes {
        case .image(let imageArray):
            return imageArray.count
        case .tag(let textArray):
            return textArray.count
        default:
            return 0
        }
        
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.delegate?.TableCollectionCellSelectIndexPath(indexPath: IndexPath(row: indexPath.row, section: self.sectionIndex))
        
        if let cell = collectionView.cellForItem(at: indexPath) as? TagViewCell {
            cell.selectedEvent(slectedIndexPath:indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.tagViewCellID, for: indexPath) as! TagViewCell
        cell.configureCell(collectionCellTypes, indexPath:indexPath )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionCellTypes {
        case .tag(_):
            self.sizingCell?.configureCell(collectionCellTypes, indexPath: indexPath)
            return (self.sizingCell?.systemLayoutSizeFitting(UILayoutFittingCompressedSize))!
        case .image(_):
            return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.height)
        default:
            break
        }
        return CGSize(width: 0, height: 0)

    }
    
}
