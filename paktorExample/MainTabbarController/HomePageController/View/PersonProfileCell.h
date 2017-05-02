//
//  PersonProfileCell.h
//  collectionViewStackLayout
//
//  Created by 林羣珩 on 2017/4/20.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *PersonProfileCellID = @"PersonProfileCellID";

@class PersonProfileCell;
typedef NS_ENUM(NSInteger,SwipeDirection){
    Right,
    Left,
    Up,
    Down,
    End
};
@protocol PersonProfileCellDelegate <NSObject>
@optional
- (void)PersonEndChoiceProfileCell:(PersonProfileCell*)cell SwipeDirection:(SwipeDirection)Direction;

- (void)PersonProfileCellMovePositionX:(CGFloat)movement MovePositionY:(CGFloat)positionY;

@end

@interface PersonProfileCell : UICollectionViewCell


@property (weak,nonatomic)id <PersonProfileCellDelegate> delegate;
@end

