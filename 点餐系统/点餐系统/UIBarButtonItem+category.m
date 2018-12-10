//
//  UIBarButtonItem+category.m
//  MeiTuan
//
//  Created by 树清吴 on 2017/10/26.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import "UIBarButtonItem+category.h"
#import "UIButton+Category.h"

@implementation UIBarButtonItem (category)

/**
 创建customView是UIbutton的UIBarButtonItem
 
 @param title 按钮普通状态下的文字
 @return UIBarButtonItem
 @param target target
 @return action
 */
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title action:(SEL)action target:(id)target{
    return [self customBarButtonItemWithTitle:title Image:nil highlighted:nil action:action target:target];
}

/**
 创建customView是UIbutton的UIBarButtonItem
 
 @param image 普通状态下的图片
 @param highlightedImg 高亮状态下的图片
 @param action action
 @param target target
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)customBarButtonItemWithImage:(NSString *)image highlighted:(NSString *)highlightedImg action:(SEL)action target:(id)target{
    return [self customBarButtonItemWithTitle:nil Image:image highlighted:highlightedImg action:action target:target];
}

/**
 创建customView是UIbutton的UIBarButtonItem
 
 @param title 按钮普通状态下的文字
 @param image 普通状态下的图片
 @param highlightedImg 高亮状态下的图片
 @param action action
 @param target target
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title Image:(NSString *)image highlighted:(NSString *)highlightedImg action:(SEL)action target:(id)target{
    
    UIButton *btn = [UIButton buttonWithTitle:nil image:image highlighted:highlightedImg background:nil backgroundHighlighted:nil target:target action:action];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [item.customView sizeToFit];
    
    return item;
}

@end
