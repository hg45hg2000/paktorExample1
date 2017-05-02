//
//  MainTabbarController.m
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/18.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import "MainTabbarController.h"
/// Controller
#import "UIViewController+Category.h"

#import "InterestController.h"

#import "ChatViewController.h"
#import "paktorExample-Swift.h"

@interface MainTabbarController ()


@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomePageController *home = [[HomePageController alloc] init];
    UINavigationController *homeNav = [home setupWithNavigationtitle:@"Home" imageName:@"" selectedImageName:@"" setTabrTitle:@"home"];
    
    InterestController *Interest = [[InterestController alloc] init];
    UINavigationController *InterestNav = [Interest setupWithNavigationtitle:@"Interes" imageName:@"" selectedImageName:@"" setTabrTitle:@"interes"];

    UserProfileController *UserProfile = [[UserProfileController alloc] init];
    UINavigationController *UserProfileNav =[UserProfile setupWithNavigationtitle:@"Me" imageName:@"" selectedImageName:@"" setTabrTitle:@"me"];

    ChatViewController * ChatView = [[ChatViewController alloc] init];
    UINavigationController *ChatViewNav = [ChatView setupWithNavigationtitle:@"Connect" imageName:@"" selectedImageName:@"" setTabrTitle:@"connect"];

    
    self.viewControllers = @[homeNav,InterestNav,UserProfileNav,ChatViewNav];
}


@end
