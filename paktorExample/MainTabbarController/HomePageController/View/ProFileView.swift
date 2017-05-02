//
//  ProFileView.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/21.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

class ProFileView: UIView {

    // Create a lazy table view
    lazy var pullDownTableView : TableView = {
        let pullDownTableView = TableView(frame:self.frame)
        pullDownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell_id")
        pullDownTableView.delegate = self
        pullDownTableView.dataSource = self
        pullDownTableView.rowHeight = 80.0
        pullDownTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pullDownTableView.bounces = false
        return pullDownTableView
    }()
    
    // 3. Gesture Handling
    private(set) lazy var swipeDownGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ProFileView.handleSwipeGestures(sender:)))
        swipeGesture.direction = .down
        return swipeGesture
    }()
    private(set) lazy var swipeUpGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ProFileView.handleSwipeGestures(sender:)))
        swipeGesture.direction = .up
        return swipeGesture
    }()
    
    func handleSwipeGestures(sender : UISwipeGestureRecognizer) {
        setMainViewExpanded(expanded: sender.direction == .down, animated: true)
    }
    
    func setMainViewExpanded(expanded: Bool, animated: Bool) {
        let topInset = pullDownTableView.contentInset.top
        let yOffset = expanded ? -topInset : -topOffset
        pullDownTableView.setContentOffset(CGPoint(x:0, y:yOffset), animated: true)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(swipeUpGesture)
        self.addGestureRecognizer(swipeDownGesture)
        
        // Create and add the pull down table view
        self.addSubview(pullDownTableView)
        
        //Set background color to contrasting color
        self.backgroundColor = UIColor.clear
        pullDownTableView.backgroundColor = UIColor.clear
    }
    
    
    // 2.
    var topOffset: CGFloat = 200.0
    
    private let kTopWindowAspectRatio : CGFloat = 3.0/4.0
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(topOffset != pullDownTableView.bounds.width * kTopWindowAspectRatio) {
            topOffset = pullDownTableView.bounds.width * kTopWindowAspectRatio
            // Setup table view insets and offsets
            let topInset = pullDownTableView.bounds.height
            pullDownTableView.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
            pullDownTableView.contentOffset = CGPoint(x:0,y:-topOffset)
        }
    }
    
    
   
}

extension ProFileView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell_id")!
    }
}

extension ProFileView : UIScrollViewDelegate,UITableViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let yInset = scrollView.contentInset.top
        
        if scrollView.contentOffset.y > -topOffset && targetContentOffset.pointee.y < -topOffset {
            targetContentOffset.pointee.y = scrollView.contentOffset.y
            scrollView.setContentOffset(CGPoint(x:0,y:-topOffset), animated: true)
        }
        else if  -topOffset > targetContentOffset.pointee.y   && targetContentOffset.pointee.y > (-topOffset + (topOffset - yInset)/2) {
            targetContentOffset.pointee.y = scrollView.contentOffset.y
            scrollView.setContentOffset(CGPoint(x:0,y:-topOffset), animated: true)
            
        }
        else if   (-topOffset + (topOffset - yInset)/2) > targetContentOffset.pointee.y {
            targetContentOffset.pointee.y = scrollView.contentOffset.y
            scrollView.setContentOffset(CGPoint(x:0,y:-topOffset), animated: true)
        }
    }
}

class TableView: UITableView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return subviews.first?.hitTest(point, with: event)
    }

}
