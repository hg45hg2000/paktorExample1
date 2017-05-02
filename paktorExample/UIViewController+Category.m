//
//  UIViewController+Category.m
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/18.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

- (UINavigationController*_Nullable)setupWithNavigationtitle:(NSString *_Nullable)title imageName:(NSString *_Nullable)imageName selectedImageName:(NSString *_Nullable)selectedImageName setTabrTitle:(NSString*)tabbartitle
{

    self.title = title;
    
    self.tabBarItem.title = tabbartitle;
    
    self.tabBarItem.image                    = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:206/255.f green:16/255.f blue:19/255.f alpha:1.f]} forState:UIControlStateSelected];
    

    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    self.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.navigationBar.barTintColor = [UIColor blackColor];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [nav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    nav.navigationBar.translucent = NO;
    return nav;
}

- (UIBarButtonItem*_Nullable)setupNavigationBarButtonPosition:(ButtonPosition)positon title:(NSString*_Nullable)title target:(id _Nullable )target action:(nullable SEL)action{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    switch (positon) {
        case ButtonPositionLeft:
          self.navigationItem.leftBarButtonItem = buttonItem;
            break;
        case ButtonPositionRight:
        self.navigationItem.rightBarButtonItem = buttonItem;
        default:
            break;
    }
    return buttonItem;
}
- (UIBarButtonItem*_Nullable)setupNavigationBarButtonPosition:(ButtonPosition)positon imageName:(NSString*_Nullable)imageName target:(id _Nullable )target action:(nullable SEL)action{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:target action:action];
    switch (positon) {
        case ButtonPositionLeft:
            self.navigationItem.leftBarButtonItem = buttonItem;
            break;
        case ButtonPositionRight:
            self.navigationItem.rightBarButtonItem = buttonItem;
        default:
            break;
    }
    return buttonItem;
}




@end
