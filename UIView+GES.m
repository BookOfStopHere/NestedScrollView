//
//  UIView+GES.m
//  DScroll
//
//  Created by yang on 16/10/8.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "UIView+GES.h"
#import <objc/runtime.h>

static NSString *key = @"disableGes______";
@implementation UIView (GES)
@dynamic disableGes;

- (void)setDisableGes:(BOOL)disableGes
{
    objc_setAssociatedObject(self, (__bridge const void *)(key), @(disableGes), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)disableGes
{
    return [objc_getAssociatedObject(self, (__bridge const void *)(key)) boolValue];
}

+ (void)load
{
//    - (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(gestureRecognizerShouldBegin:);
        SEL swizzledSelector = @selector(ymh_gestureRecognizerShouldBegin:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL)ymh_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return  YES;//
    !self.disableGes;
}
@end
