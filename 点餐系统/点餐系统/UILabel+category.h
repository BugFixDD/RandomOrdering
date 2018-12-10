//
//  UILabel+category.h
//  QQZone
//
//  Created by 树清吴 on 2017/10/17.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (category)


/**
 创建一个label，
 - 文字大小默认是14号字体
 - 颜色默认是黑色
 - 对齐方式默认是居中

 @param title label里面的文字
 @return label
 */
+ (instancetype)labelWithTitle:(NSString *)title;


/**
 创建一个label

 @param title label里面的文字
 @param size 如果传0，文字大小默认是14号字体
 @param alignment 对齐方式
 @param color 颜色
 @return label
 */
+ (instancetype)labelWithTitle:(NSString *)title size:(NSInteger)size textAlignment:(NSTextAlignment)alignment color:(UIColor *)color;

@end
