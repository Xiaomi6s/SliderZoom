//
//  MainCell.m
//  SlideZoomMenuDemo
//
//  Created by jian on 15/4/9.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)awakeFromNib {
    self.imgView.layer.cornerRadius = 25;
    self.imgView.layer.masksToBounds = YES;
    self.detail.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 60;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
