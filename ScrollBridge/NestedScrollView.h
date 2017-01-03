//
//  NestedScrollView.h
//  DScroll
//
//  Created by yang on 17/1/3.
//  Copyright © 2017年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NestedScrollView : UIView

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)setContentSize:(CGSize)contentSize;

@end
