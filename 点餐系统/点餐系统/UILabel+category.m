//
//  UILabel+category.m
//  QQZone
//
//  Created by 树清吴 on 2017/10/17.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//

#import "UILabel+category.h"

@implementation UILabel (category)

+ (instancetype)labelWithTitle:(NSString *)title{
    return [self labelWithTitle:title size:0 textAlignment:1 color:nil];
}

+ (instancetype)labelWithTitle:(NSString *)title size:(NSInteger)size textAlignment:(NSTextAlignment)alignment color:(UIColor *)color{
    UILabel *label = [self new];
    label.text = title;
    label.textAlignment = alignment;
    if (size == 0) {
        label.font = [UIFont systemFontOfSize:14];
    }else{
        label.font = [UIFont systemFontOfSize:size];
    }
    if (color != nil) {
        
        label.textColor = color;
    }else{
        label.textColor = [UIColor blackColor];
    }
    
    return label;
}

@end
