//
//  stackLayout.m
//  collectionViewStackLayout
//
//  Created by 林羣珩 on 2017/4/19.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import "stackLayout.h"
@interface stackLayout()
@property (nonatomic,strong)NSMutableArray <UICollectionViewLayoutAttributes*> *attributes;
@property (nonatomic,assign)CGPoint center;
@property (nonatomic,assign)CGFloat radius;
@property (nonatomic,assign)NSInteger totalcellcount;
@end
@implementation stackLayout


- (void)prepareLayout{
    [super prepareLayout];
    self.totalcellcount = [self.collectionView numberOfItemsInSection:0];
    
    
    self.attributes = [NSMutableArray arrayWithCapacity:self.totalcellcount];
    
    self.center = CGPointMake((double)self.collectionView.bounds.size.width * 0.5, (double)self.collectionView.bounds.size.height * 0.5);
    
    self.radius = MIN(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)/3.0;
    
    for (int  index = 0 ; index < self.totalcellcount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
         UICollectionViewLayoutAttributes *Attribute = [self calculatelayoutindexPath:indexPath];
        [self.attributes  addObject:Attribute];
        
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
   return  [self calculatelayoutindexPath:indexPath];
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributes;
}

- (CGSize)collectionViewContentSize{
    return self.collectionView.bounds.size;
}

#pragma mark 

- (UICollectionViewLayoutAttributes *)calculatelayoutindexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *Attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    Attribute.size = CGSizeMake(self.collectionView.bounds.size.width + (indexPath.row * 20), self.collectionView.bounds.size.height);
    Attribute.center = CGPointMake(self.collectionView.bounds.size.width/2 , self.collectionView.bounds.size.height/2+(indexPath.row *20));
    return Attribute;
}

@end
