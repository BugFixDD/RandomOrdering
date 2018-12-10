//
//  UIView+SetFrame.h
//  图片播放器
//
//  Created by 树清吴 on 2017/7/26.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//


// 这个类的作用是可以方便地设置view的大小和xy
#import <UIKit/UIKit.h>

@interface UIView (SetFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


@end
