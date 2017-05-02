//
//  UIViewController+Category.h
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/18.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ButtonPosition){
    ButtonPositionLeft,
    ButtonPositionRight
};

@interface UIViewController (Category)

- (UINavigationController*_Nullable)setupWithNavigationtitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName selectedImageName:(NSString *_Nullable)selectedImageName setTabrTitle:(NSString*_Nullable)tabbartitle;

- (UIBarButtonItem*_Nullable)setupNavigationBarButtonPosition:(ButtonPosition)positon title:(NSString*_Nullable)title target:(id _Nullable )target action:(nullable SEL)action;

- (UIBarButtonItem*_Nullable)setupNavigationBarButtonPosition:(ButtonPosition)positon imageName:(NSString*_Nullable)imageName target:(id _Nullable )target action:(nullable SEL)action;

@end
