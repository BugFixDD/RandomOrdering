//
//  UIBarButtonItem+category.h
//  MeiTuan
//
//  Created by 树清吴 on 2017/10/26.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (category)

/**
 创建customView是UIbutton的UIBarButtonItem
 
 @param title 按钮普通状态下的文字
 @return UIBarButtonItem
 @param target target
 @return action
 */
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title action:(SEL)action target:(id)target;

/**
 创建customView是UIbutton的UIBarButtonItem

 @param image 普通状态下的图片
 @param highlightedImg 高亮状态下的图片
 @param action action
 @param target target
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)customBarButtonItemWithImage:(NSString *)image highlighted:(NSString *)highlightedImg action:(SEL)action target:(id)target;


/**
 创建customView是UIbutton的UIBarButtonItem

 @param title 按钮普通状态下的文字
 @param image 普通状态下的图片
 @param highlightedImg 高亮状态下的图片
 @param action action
 @param target target
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title Image:(NSString *)image highlighted:(NSString *)highlightedImg action:(SEL)action target:(id)target;

@end
