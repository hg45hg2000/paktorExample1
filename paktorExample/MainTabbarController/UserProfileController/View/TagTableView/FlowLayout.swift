//
//  FlowLayoyt.swift
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/24.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

import UIKit

class TagFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        self.minimumLineSpacing = 1
        self.minimumInteritemSpacing = 1
    
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        
        var leftMargin: CGFloat = 0.0;
        
        for attributes in attributesForElementsInRect! {
            if (attributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            leftMargin += attributes.frame.size.width + 8
            newAttributesForElementsInRect.append(attributes)
        }
        
        return newAttributesForElementsInRect
    }
}
class ImageFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        self.sectionInset = UIEdgeInsets.zero
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
}
