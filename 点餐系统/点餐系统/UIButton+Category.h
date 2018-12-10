//
//  UIButton+Category.h
//  QQZone
//
//  Created by 树清吴 on 2017/10/17.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)


/**
 创建button，系统类型的按钮，参数设置的是normal状态下的

 @param title 按钮文字， 默认是黑色
 @param target target
 @param action action
 @return button
 */
+ (instancetype)normalButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;


/**
 创建按钮，系统类型的按钮

 @param title 按钮文字, 默认是蓝色
 @param imageName normal状态下的图片
 @param highlightedName 高亮状态下的图片
 @param background normal状态下的背景图
 @param backgroundHighlighted 高亮状态下的背景图
 @param target target
 @param action action
 @return button
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)imageName highlighted:(NSString *)highlightedName background:(NSString *)background backgroundHighlighted:(NSString *)backgroundHighlighted target:(id)target action:(SEL)action;

@end




