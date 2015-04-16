//
//  SLideZoomMenuController.h
//  SlideZoomMenuDemo
//
//  Created by renxiaojian on 15/3/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLideZoomMenuController : UIViewController

@property(nonatomic, strong) UIViewController *leftViewController;
@property(nonatomic, strong) UIViewController *rootViewController;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

- (id)initWithRootController:(UIViewController *)rootViewController;


@end

