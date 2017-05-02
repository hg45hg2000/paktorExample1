//
//  ChatViewController.m
//  paktorExample
//
//  Created by 林羣珩 on 2017/4/18.
//  Copyright © 2017年 林羣珩. All rights reserved.
//

#import "ChatViewController.h"
#import "UIScrollView+SVPullToRefresh.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)UISearchController *searchController;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBarButtonPosition:ButtonPositionLeft imageName:@"Gift_20" target:self action:nil];
    [self setupNavigationBarButtonPosition:ButtonPositionRight imageName:@"Comments_20" target:self action:nil];
    [self setupTableView];
    [self setupSearchController];
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = true;
    [self.view addSubview:self.tableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.tableView addGestureRecognizer:tap];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupAutoLayout];
}
- (void)closeKeyboard{
    [self.view.window endEditing:YES];
}

- (void)setupSearchController{
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    // 將更新搜尋結果的對象設為 self
//    self.searchController.searchResultsUpdater = self;
////    self.searchController.delegate = self;
//    // 搜尋時是否隱藏 NavigationBar
//    self.searchController.hidesNavigationBarDuringPresentation = false;
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    // 搜尋時是否使用燈箱效果 (會將畫面變暗以集中搜尋焦點)
    self.searchController.dimsBackgroundDuringPresentation = false;
    searchbar.searchBarStyle = UISearchBarStyleMinimal;
    [searchbar setPlaceholder:@"Search your Matches"];
    self.tableView.tableHeaderView = searchbar;
}

- (void)setupAutoLayout{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    [self.view addConstraints:@[top,right,bottom,left]];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
#pragma mark 
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
- (void)didPresentSearchController:(UISearchController *)searchController{
    [self.searchController.searchBar setShowsCancelButton:NO];
}

@end
