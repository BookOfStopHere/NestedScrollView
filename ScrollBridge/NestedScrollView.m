//
//  NestedScrollView.m
//  DScroll
//
//  Created by yang on 17/1/3.
//  Copyright © 2017年 yang. All rights reserved.
//

#import "NestedScrollView.h"
#import "BOSHScrollView.h"

@interface NestedScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) BOSHScrollView *scrollView;
@end


@implementation NestedScrollView

- (BOSHScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[BOSHScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [self.scrollView insertSubview:view atIndex:index];
}

- (void)setContentSize:(CGSize)contentSize
{
    self.scrollView.contentSize = contentSize;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}
@end
