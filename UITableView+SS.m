//
//  UITableView+SS.m
//  DScroll
//
//  Created by yang on 16/10/9.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "UITableView+SS.h"

@implementation UITableView (SS)
//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view
//{
//    return NO;
//}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
////    if (self.tableHeaderView && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
////        return NO;
////    }
//    return NO;
//    return [super pointInside:point withEvent:event];
//}
@end
