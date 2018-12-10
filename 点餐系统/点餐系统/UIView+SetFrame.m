//
//  UIView+SetFrame.m
//  图片播放器
//
//  Created by 树清吴 on 2017/7/26.
//  Copyright © 2017年 shuQingWu. All rights reserved.
//


// 这个类的作用是可以方便地设置view的大小和xy
#import "UIView+SetFrame.h"

@implementation UIView (SetFrame)

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.bounds.size.width;
}

- (CGFloat)height{
    return self.bounds.size.height;
}

- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}



@end
