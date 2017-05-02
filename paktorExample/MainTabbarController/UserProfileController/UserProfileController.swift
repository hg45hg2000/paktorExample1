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

     var dataTypes :Array<tabelCellType> = [tabelCellType.collectioView(CollectionCellType.tag([Tag(name: "", selected: true),Tag(name: "", selected: true),Tag(name: "", selected: true),Tag(name: "", selected: true),Tag(name: "", selected: true)])),
                                            
                                            tabelCellType.collectioView(CollectionCellType.image([UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!,UIImage (named: "photo_sample_01")!])),
                                                                         
                                           tabelCellType.tableview(InformCelltype.text([TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank"),TextData(leftText: "fuck", rightText: "gank")])),
                                                                  
                                           tabelCellType.tableview(InformCelltype.silder([SilderData(value:1)]))

    
    ]
    
    var header : StretchHeader!
    
    var tableView : UITableView!
    
    var navigationView = UIView()

    var collectionViewHeight :CGFloat = 0
    
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
    }
    
    private func navigatBarItem(){
        // NavigationHeader
        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = UIColor(red: 121/255.0, green: 193/255.0, blue: 203/255.0, alpha: 1.0)
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 20, width: 44, height: 44)
        button.setImage(UIImage(named: "navi_back_btn")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(UserProfileController.leftButtonAction), for: .touchUpInside)
        view.addSubview(button)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let tagcell = tableView.dequeueReusableCell(withIdentifier: TagTableCell.TagTableCellID, for: indexPath) as! TagTableCell
                tagcell.configureCellData(CellType: dataTypes[indexPath.row])
            return tagcell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch dataTypes[indexPath.row] {
        case .collectioView( _):
             return dataTypes[indexPath.row].collectionCellHeight
        case .tableview(_):
            return dataTypes[indexPath.row].tableviewCellHeight
        }
    }
}


