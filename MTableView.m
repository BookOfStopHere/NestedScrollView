//
//  MTableView.m
//  DScroll
//
//  Created by yang on 16/11/6.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "MTableView.h"

@implementation MTableView
//
//- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view
//{
//    return NO;
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return [super pointInside:point withEvent:event];
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
