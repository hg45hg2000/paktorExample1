//
//  UserProfileController.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/21.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width

let screenHeight = UIScreen.main.bounds.height

class UserProfileController: BaseViewController {

    var dataTypes :Array<tabelCellType>!
    
    var header : StretchHeader!
    
    var tableView : UITableView!
    
    var navigationView = NavigationBarView()

    var collectionViewHeight :CGFloat = 0
     var SilderDatas = SilderData(value:1)
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTypes  = [
            tabelCellType.collectioView(CollectionCellType.tag(
                [Tag(name: "sdfsdfsd", selected: false),Tag(name: "sdfsdfs", selected: false),
                 Tag(name: "sdfsdf", selected: false),Tag(name: "sdfsdf", selected: false),Tag(name: "sdfsdfs", selected: false)])),
        
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
        
        tabelCellType.tableview(InformCelltype.text([TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank")])),
        
        tabelCellType.tableview(InformCelltype.silder([SilderDatas])),
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
        tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!]))
        ]
        
        setupTableView()
        setupHeaderView()
        navigatBarItem()
    }
    
    
    private func setupTableView(){
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 47), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "TagTableCell", bundle: nil), forCellReuseIdentifier:TagTableCell.TagTableCellID)
    }
    
    private func navigatBarItem(){

        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = NavigationBarView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: navibarHeight + statusbarHeight))
        view.addSubview(navigationView)
    }
    
    func setupHeaderView() {
        
        let options = StretchHeaderOptions()
        options.position = .fullScreenTop
        
        header = StretchHeader()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 300),
                                 imageSize: CGSize(width: view.frame.size.width, height: 300),
                                 controller: self,
                                 options: options)
        header.imageView.image = UIImage(named: "photo_sample_01")
        
        header.setupInfoViewText(text: "Uh_oh! You need to upload 2 more \n photos to have them rated")
        
        tableView.tableHeaderView = header
    }
    
    // MARK: - Selector
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserProfileController:UITableViewDelegate,UITableViewDataSource{
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.updateScrollViewOffset(scrollView)
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
        } else {
            navigationView.alpha = 0.0;
        }
    }
    public func numberOfSections(in tableView: UITableView) -> Int{
         return dataTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let tagcell = tableView.dequeueReusableCell(withIdentifier: TagTableCell.TagTableCellID, for: indexPath) as! TagTableCell
                tagcell.configureCellData(CellType: dataTypes[indexPath.section])
                tagcell.delegate = self
                tagcell.sectionIndex = indexPath.section
            return tagcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch dataTypes[indexPath.section] {
        case .collectioView( _):
             return dataTypes[indexPath.section].collectionCellHeight
        case .tableview(_):
            return dataTypes[indexPath.section].tableviewCellHeight
        }
    }
}
extension UserProfileController:TagTableCellDelegate{
    
    func TageTableSelectIndexPath(indexPath:IndexPath){
        switch dataTypes[indexPath.section] {
        case .collectioView(let collectioncellType):
            switch collectioncellType {
            case .tag(var tagArray):
                print(" slected \(tagArray[indexPath.row].selected)")
                tagArray[indexPath.row].selected = !tagArray[indexPath.row].selected
                print(" slected \(tagArray[indexPath.row].selected)")
            default:break
            }
            break
        case .tableview( _):
            break
        }
        print("selected data type \(dataTypes[indexPath.section])")
    }
}


