//
//  LeftViewController.h
//  SlideZoomMenuDemo
//
//  Created by renxiaojian on 15/3/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *picImgView;

@property (nonatomic, assign) BOOL didSelectInitialViewController;

@property(nonatomic, assign) int selectedIndex;

@end
