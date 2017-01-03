//
//  QNUIWebView.m
//  DScroll
//
//  Created by yang on 16/9/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "QNUIWebView.h"

@implementation QNUIWebView
static float cur_offset = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if(scrollView.contentOffset.y > cur_offset)
//    {
//        scrollView.bounces = NO;
//    }
//    else
//    {
//        scrollView.bounces = YES;
//    }
    NSLog(@"YANG,%lf,%f\n",CFAbsoluteTimeGetCurrent(),scrollView.contentOffset.y);
    [super scrollViewDidScroll:scrollView];
    [self.sDeleagte scrollViewDidScroll:scrollView];
}// any offset changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
     [super scrollViewDidZoom:scrollView];
    [self.sDeleagte scrollViewDidZoom:scrollView];
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
     cur_offset = scrollView.contentOffset.y;
     [super scrollViewWillBeginDragging:scrollView];
    [self.sDeleagte scrollViewWillBeginDragging:scrollView];
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
     [self.sDeleagte scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [self.sDeleagte scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
     [self.sDeleagte scrollViewWillBeginDecelerating:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     [super scrollViewDidEndDecelerating:scrollView];
    
    [self.sDeleagte scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
     [self.sDeleagte scrollViewDidEndScrollingAnimation:scrollView];
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
     return [super viewForZoomingInScrollView:scrollView];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view
{
     [super scrollViewWillBeginZooming:scrollView withView:view];
    
    [self.sDeleagte scrollViewWillBeginZooming:scrollView withView:view];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
     [super scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    
     [self.sDeleagte scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [super scrollViewDidScrollToTop:scrollView];
    
    [self.sDeleagte scrollViewDidScrollToTop:scrollView];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    //    if(CGRectContainsPoint(CGRectMake(0,0,self.bounds.size.width,self.contentInset.top), point))
//    //    {
//    //        return nil;
//    //    }
//    if(point.y < 0) return nil;
//    
//    return [super hitTest:point withEvent:event];
//}
@end
