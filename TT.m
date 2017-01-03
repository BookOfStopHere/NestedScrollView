//
//  TT.m
//  DScroll
//
//  Created by yang on 16/9/22.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "TT.h"

@implementation TT

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    if(CGRectContainsPoint(CGRectMake(0,0,self.bounds.size.width,self.contentInset.top), point))
//    {
//        return nil;
//    }
    if(point.y < 0)
    {
        self.showsVerticalScrollIndicator = NO;
        return nil;
    }
self.showsVerticalScrollIndicator = YES;
    return [super hitTest:point withEvent:event];
}
@end
