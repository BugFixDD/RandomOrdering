//
//  UIButton+Category.m
//  QQZone
//
//  Created by 树清吴 on 2017/10/17.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

+ (instancetype)normalButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    return [self buttonWithTitle:title image:nil highlighted:nil background:nil backgroundHighlighted:nil target:target action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)imageName highlighted:(NSString *)highlightedName background:(NSString *)background backgroundHighlighted:(NSString *)backgroundHighlighted target:(id)target action:(SEL)action {
    
    UIButton *btn = [self buttonWithType:UIButtonTypeSystem];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:18 / 255.0  green:106 / 255.0  blue:255 / 255.0 alpha:1] forState:UIControlStateNormal];
    
    UIImage *img = [UIImage imageNamed:imageName];
    [btn setImage:img forState:UIControlStateNormal];
    UIImage *highlightedImg = [UIImage imageNamed:highlightedName];
    [btn setImage:highlightedImg forState:UIControlStateHighlighted];
    
    UIImage *backImg = [UIImage imageNamed:background];
    [btn setBackgroundImage:backImg forState:UIControlStateNormal];
    UIImage *backHImg = [UIImage imageNamed:backgroundHighlighted];
    [btn setBackgroundImage:backHImg forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
