//
//  SLideZoomMenuController.m
//  SlideZoomMenuDemo
//
//  Created by renxiaojian on 15/3/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import "SLideZoomMenuController.h"

@interface SLideZoomMenuController ()

@property(nonatomic, assign) BOOL isShow;
@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, strong) UIPanGestureRecognizer *rightPan;
@property(nonatomic, strong) UIPanGestureRecognizer *leftPan;
@property(nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation SLideZoomMenuController

- (id)initWithRootController:(UIViewController *)rootViewController
{
    self = [self init];
    if (self) {
        self.rootViewController = rootViewController;
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isShow = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)setupRoot
{
    if (self.rootViewController) {
        UIView *view = self.rootViewController.view;
        view.frame = self.view.frame;
        [self.bgImageView addSubview:view];
        [self addmenuItem];
    }
}

- (void)addmenuItem
{
    UIViewController *mainViewcontroller = nil;
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self.rootViewController;
        mainViewcontroller = nav.viewControllers.firstObject;
    }
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"左" style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
    mainViewcontroller.navigationItem.leftBarButtonItem = barItem;
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController) {
        [_rootViewController.view removeFromSuperview];
        _rootViewController = nil;
    }
    _rootViewController = rootViewController;
    [self setupRoot];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = (id <UIGestureRecognizerDelegate>)self;
    [self.rootViewController.view addGestureRecognizer:pan];
    self.rightPan = pan;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.rootViewController.view addGestureRecognizer:tap];
    self.tap = tap;
    tap.enabled = NO;
    
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
    leftPan.delegate = (id <UIGestureRecognizerDelegate>)self;
    [self.rootViewController.view addGestureRecognizer:leftPan];
    self.leftPan = leftPan;
    self.leftPan.enabled = NO;
    if (self.isShow) {
        
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = self.view.bounds.size.width - 60;
        rect.origin.y = self.view.bounds.size.height/4;
        rect.size.height = self.view.bounds.size.height/2;
        rect.size.width = self.view.bounds.size.width/2;
        self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        self.rootViewController.view.frame = rect;
        [self showLeft];
    }

}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    _leftViewController = leftViewController;
    UIView *view = self.leftViewController.view;
    view.frame = self.view.frame;
    [self.bgImageView insertSubview:view atIndex:0];
    [self performSelector:@selector(setupLeft) withObject:nil afterDelay:0.01];
   
}

- (void)setupLeft
{

    CGRect rect = self.leftViewController.view.frame;
    rect.origin.x = -60;
    rect.origin.y = self.view.bounds.size.height/4;
    rect.size.height = self.view.bounds.size.height/2;
    rect.size.width = self.view.bounds.size.width/2;
    self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.leftViewController.view.frame = rect;
    self.leftViewController.view.alpha = 0;

}

- (void)rootIsSCrolling:(BOOL)isScroll
{
    UIViewController *mainViewcontroller = nil;
    if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self.rootViewController;
        mainViewcontroller = nav.viewControllers.firstObject;
        mainViewcontroller.view.userInteractionEnabled = isScroll;
    }
}

- (void)handleLeftPan:(UIPanGestureRecognizer *)leftPan
{
     CGPoint locationPoint = [leftPan locationInView:self.view];
    CGFloat offsetX = - (locationPoint.x - self.startPoint.x);
    if (leftPan.state == UIGestureRecognizerStateChanged) {
        if (locationPoint.x -self.startPoint.x <= -6) {
            CGFloat leftOffsetX = offsetX * 60/(self.view.bounds.size.width - 60);
            CGFloat rootZoom = offsetX/(self.view.bounds.size.width - 60) * 0.5;
            CGRect rootRect = self.rootViewController.view.frame;
            rootRect.origin.x = [UIScreen mainScreen].bounds.size.width- 60 - offsetX;
            self.rootViewController.view.frame = rootRect;
            self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5+ rootZoom, 0.5 +rootZoom);
            CGRect leftRect = self.leftViewController.view.frame;
            leftRect.origin.x = -leftOffsetX;
            self.leftViewController.view.frame = leftRect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(1-rootZoom ,1-rootZoom);
            self.leftViewController.view.alpha = 1.0 - offsetX/(self.view.bounds.size.width - 60) *1.0;
        }
        else
        {
            return;
        }
        if (offsetX >= (self.view.bounds.size.width - 60)) {
            leftPan.enabled = NO;
        }
    }
    else if (leftPan.state == UIGestureRecognizerStateCancelled || leftPan.state == UIGestureRecognizerStateEnded)
    {
        if (offsetX >= [UIScreen mainScreen].bounds.size.width/2) {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width =  self.view.bounds.size.width;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = -60;
            rect2.origin.y = self.view.bounds.size.height/4;
            rect2.size.height = self.view.bounds.size.height/2;
            rect2.size.width = self.view.bounds.size.width/2;
            [UIView animateWithDuration:.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.isShow = !self.isShow;
                self.rightPan.enabled = YES;
                self.leftPan.enabled = NO;
                self.tap.enabled = NO;
                [self rootIsSCrolling:YES];
            }];
            
            
        }
        else
        {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = self.view.bounds.size.width - 60;
            rect.origin.y = self.view.bounds.size.height/4;
            rect.size.height = self.view.bounds.size.height/2;
            rect.size.width = self.view.bounds.size.width/2;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = 0;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = self.view.bounds.size.width;
            [UIView animateWithDuration:0.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                self.isShow = YES;
                self.leftPan.enabled = YES;
                self.tap.enabled = YES;
                [self rootIsSCrolling:NO];
            }];
            
        }

    }

}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if (self.isShow) {
        [self showLeft];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint locationPoint = [pan locationInView:self.view];
   CGFloat offsetX = locationPoint.x - self.startPoint.x;
    if (pan.state == UIGestureRecognizerStateChanged) {
        if (locationPoint.x -self.startPoint.x >=6) {
            CGFloat leftOffsetX = offsetX * 60/(self.view.bounds.size.width - 60);
            CGFloat rootZoom = offsetX/(self.view.bounds.size.width - 60) * 0.5;
            CGRect rootRect = self.rootViewController.view.frame;
            rootRect.origin.x = offsetX;
            self.rootViewController.view.frame = rootRect;
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1-rootZoom, 1-rootZoom);
            CGRect leftRect = self.leftViewController.view.frame;
            leftRect.origin.x = leftOffsetX - 60;
            leftRect.size.width = self.view.bounds.size.width/2 + leftOffsetX *self.view.bounds.size.width/2/60;
            self.leftViewController.view.frame = leftRect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5 +rootZoom , 0.5 +rootZoom);
            self.leftViewController.view.alpha = offsetX/(self.view.bounds.size.width - 60) *1.0;
        }
        else
        {
            return;
        }
    
        if (offsetX >= (self.view.bounds.size.width - 60)) {
            pan.enabled = NO;
        }
    }
    else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled)
    {
        if (offsetX >= [UIScreen mainScreen].bounds.size.width/2) {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = self.view.bounds.size.width - 60;
            rect.origin.y = self.view.bounds.size.height/4;
            rect.size.height = self.view.bounds.size.height/2;
            rect.size.width = self.view.bounds.size.width/2;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = 0;
            rect2.origin.y = 0;
            rect2.size.height = self.view.bounds.size.height;
            rect2.size.width = self.view.bounds.size.width;
            [UIView animateWithDuration:0.25 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                self.isShow = YES;
                self.leftPan.enabled = YES;
                self.tap.enabled = YES;
                [self rootIsSCrolling:NO];
            }];
            

        }
        else
        {
            CGRect rect = self.rootViewController.view.frame;
            rect.origin.x = 0;
            rect.origin.y = 0;
            rect.size.height = self.view.bounds.size.height;
            rect.size.width = self.view.bounds.size.width;
            CGRect rect2 = self.leftViewController.view.frame;
            rect2.origin.x = -60;
            rect2.origin.y = self.view.bounds.size.height/4;
            rect2.size.height = self.view.bounds.size.height/2;
            rect2.size.width = self.view.bounds.size.width/2;
            [UIView animateWithDuration:0.15 animations:^{
                self.rootViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                self.rootViewController.view.frame = rect;
                self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                self.leftViewController.view.frame = rect2;
                self.leftViewController.view.alpha = 0;
            } completion:^(BOOL finished) {
                self.isShow = NO;
                self.tap.enabled = NO;
            }];

        }
    }
    
    
}

- (void)showLeft
{
    if (!self.isShow) {
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = [UIScreen mainScreen].bounds.size.width- 60;
        rect.origin.y =self.view.bounds.size.height/4;
        rect.size.height = self.view.bounds.size.height/2;
        rect.size.width = self.view.bounds.size.width/2;
        CGRect rect2 = self.leftViewController.view.frame;
        rect2.origin.x = 0;
        rect2.origin.y = 0;
        rect2.size.height = self.view.bounds.size.height;
        rect2.size.width = self.view.bounds.size.width;
        [UIView animateWithDuration:.35 animations:^{
            self.rootViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self.rootViewController.view.frame = rect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.leftViewController.view.frame = rect2;
            self.leftViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.isShow = !self.isShow;
            self.leftPan.enabled = YES;
            self.tap.enabled = YES;
            [self rootIsSCrolling:NO];
        }];
 
    }
    else
    {
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        rect.size.height = self.view.bounds.size.height;
        rect.size.width =  self.view.bounds.size.width;
        CGRect rect2 = self.leftViewController.view.frame;
        rect2.origin.x = -60;
        rect2.origin.y = self.view.bounds.size.height/4;
        rect2.size.height = self.view.bounds.size.height/2;
        rect2.size.width = self.view.bounds.size.width/2;
        [UIView animateWithDuration:.35 animations:^{
            self.rootViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            self.rootViewController.view.frame = rect;
            self.leftViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self.leftViewController.view.frame = rect2;
            self.leftViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            self.isShow = !self.isShow;
            self.rightPan.enabled = YES;
            self.leftPan.enabled = NO;
            self.tap.enabled = NO;
            [self rootIsSCrolling:YES];
        }];

    }
}


#pragma mark- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    self.startPoint = [gestureRecognizer locationInView:self.view];
    if (gestureRecognizer == self.rightPan) {
        if ([self.rootViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)self.rootViewController;
            NSArray *viewControllers = nav.viewControllers;
            if (viewControllers.count > 1) {
                return NO;
            }
        }

    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
