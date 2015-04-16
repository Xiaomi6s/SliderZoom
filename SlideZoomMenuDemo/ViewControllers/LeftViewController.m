//
//  LeftViewController.m
//  SlideZoomMenuDemo
//
//  Created by renxiaojian on 15/3/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "LeftCell.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSArray *titles;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"我的QQ会员",@"QQ钱包",@"网上营业厅",@"我的好友",@"我的群聊",@"我的收藏"];
    self.picImgView.layer.cornerRadius = 30;
    self.picImgView.layer.masksToBounds = YES;
    self.picImgView.backgroundColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LeftCell" bundle:nil] forCellReuseIdentifier:@"LeftCell"];
    [self performSelector:@selector(setupSlected) withObject:nil afterDelay:0.01];
   
}

- (void)setupSlected
{
     [self tableView:[self tableView] didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LeftCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text =[NSString stringWithFormat: @"%@",self.titles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    if (indexPath.row % 2 == 1) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        app.slider.rootViewController = nav;
    }
    else {
        MainViewController *mainVC = [[MainViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
        app.slider.rootViewController = nav;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
