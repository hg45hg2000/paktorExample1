//
//  HomePageController.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/21.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

class HomePageController: BaseViewController,CollectionPushAndPoppable{

    @IBOutlet weak var collectionView: UICollectionView?{
        didSet{
            collectionView?.register(UINib.init(nibName: "PersonProfileCell", bundle: nil), forCellWithReuseIdentifier: PersonProfileCellID)
            collectionView?.setCollectionViewLayout(stackLayout(), animated: true)
        }
    }
    var sourceCell: UICollectionViewCell?

    @IBOutlet weak var checkImageView: ChoiceImageView!
    
    var sourceview: UIView!
    
    var  personalArray : [String] = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.delegate = self
        
    }
}
extension HomePageController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return personalArray.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier:PersonProfileCellID , for: indexPath) as! PersonProfileCell
        cell.backgroundColor = .random()
        cell.delegate = self as PersonProfileCellDelegate
        cell.indexPath = indexPath
        return cell
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        let selectedCell = collectionView.cellForItem(at: indexPath)
//        sourceCell = selectedCell
//        let viewcontroller = UIViewController()
//        viewcontroller.view.backgroundColor = UIColor.white
//        self.navigationController?.pushViewController(viewcontroller, animated: true)
        
    }
}
extension HomePageController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopInAndOutAnimator(operation: operation)
    }
}

extension HomePageController: PersonProfileCellDelegate{
    
    public func personEndChoiceProfileCell(at IndexPath: IndexPath!, swipeDirection Direction: SwipeDirection){
        
        
        switch Direction {
        case .Left:
            self .deleteDataAtIndex(index: IndexPath)
        case .Right:
            self .deleteDataAtIndex(index: IndexPath)
        default:break
        }
        
        checkImageView.changeType(ImageViewType: .Blank)
    }
    
    func personProfileCellMovePositionX(_ movement: CGFloat, movePositionY positionY: CGFloat){
        /// like
        if  movement > 0.5 {
            checkImageView.changeType(ImageViewType: .Check)
            
        }// dislike
        else if movement < -0.5 {
            checkImageView.changeType(ImageViewType: .Cross)
        }
        checkImageView.alpha = min(max(abs(movement), 0), 1)
    }
    
    private func deleteDataAtIndex(index:IndexPath){
        print("delete index \(index.row)")
        personalArray.remove(at: index.row)
        self.collectionView?.deleteItems(at: [IndexPath(row: index.row, section: 0)])
        self.collectionView?.performBatchUpdates({
            
        }, completion: { (finsh) in
            if finsh {
                self.addData()
            }
        })
    }
    private func addData(){
        self.collectionView?.performBatchUpdates({
            self.personalArray.insert("", at: 0)
            self.collectionView?.insertItems(at: [IndexPath(row: 0, section: 0)])
        }, completion: { (finsin) in
            
        })
    }
}

