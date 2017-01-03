//
//  SWXTViewController.m
//  DScroll
//
//  Created by yang on 16/10/8.
//  Copyright © 2016年 yang. All rights reserved.
//
#import <JavaScriptCore/JavaScriptCore.h>
#import "SWXTViewController.h"
static void *sconetext = &sconetext;
static void *oconetext = &oconetext;
@implementation SWXTViewController
{
    CGFloat maxHeight;
    
    CGFloat offset;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    offset = self.view.bounds.size.height;
    
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.backgroundColor = [UIColor clearColor];
    _table.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:UITableViewCell.class  forCellReuseIdentifier:@"class"];
    
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,-offset, self.view.bounds.size.width, self.view.bounds.size.height)];
    //    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.bounces = NO;
//    _table.contentInset = UIEdgeInsetsMake(self.view.bounds.size.height , 0, 0, 0);
//    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.view.bounds.size.height , 0);
    [_webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:oconetext];
    [_table addSubview:_webView];
    
    
    _table.delaysContentTouches = NO;
    _table.canCancelContentTouches = NO;
    
    
    [_webView.scrollView.panGestureRecognizer addTarget:self  action:@selector(handlePan:)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5NTUxOTc4Mw==&mid=2650453655&idx=1&sn=e71a78408e68a64b7c68be4851a908c3"]]];
    //     [_table.panGestureRecognizer requireGestureRecognizerToFail:_webView.scrollView.panGestureRecognizer];
    //    [_webView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:_table.panGestureRecognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    UIScrollView *view = (UIScrollView *)pan.view;
    //    if(view.contentOffset.y >= view.contentSize.height)
    //    {
    ////        [_table.panGestureRecognizer requireGestureRecognizerToFail:_table.panGestureRecognizer];
    //        _webView.scrollView.disableGes = YES;
    //    }
    //    else
    //    {
    //        _webView.scrollView.disableGes = NO;
    //        [_table.panGestureRecognizer requireGestureRecognizerToFail:_webView.scrollView.panGestureRecognizer];
    //    }
    CGPoint p = [pan translationInView:_webView.scrollView];
    [_table.panGestureRecognizer setTranslation:p inView:_table];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if(context == oconetext)
    {
        CGPoint point = [change[NSKeyValueChangeOldKey] CGPointValue];
        CGPoint npoint = [change[NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"####____%f_____%f\n",_webView.scrollView.contentSize.height,npoint.y);
        
        //            [_table setContentOffset:CGPointMake(0, -maxHeight +  npoint.y) animated:NO];
        NSLog(@"offset:%f",npoint.y);
    }
}
- (void)reloadFrame
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.addEventListener(\"DOMMouseScroll\" ,scrollFunction, false); function scrollFunction () {console.log('scrolllllllsdkjajdjkajdjka');}"];
    NSString *hStr =  [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    NSLog(@"");
    
    CGRect frame;// = _webView.frame;
    frame.size.height =  MIN([hStr floatValue],_webView.scrollView.contentSize.height);
    maxHeight = frame.size.height;
//    _table.frame = CGRectMake(0, maxHeight, self.view.bounds.size.width, self.view.bounds.size.height);
//    offset = 200;
//    _table.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
//    _webView.frame = CGRectMake(0,-offset, self.view.bounds.size.width, offset);
    
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"print"] =  ^(id log){
        NSLog(@"________%@",log);
    };
    context[@"page_scroll"] = ^(){
        NSLog(@"滑动中－－－－－－－\n");
        [webView stringByEvaluatingJavaScriptFromString:@"print(window.scrollY);"];
    };
    [webView stringByEvaluatingJavaScriptFromString:@"document.addEventListener(\"scroll\", page_scroll, false);"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"class"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    //    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 2.0;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"__UISCrollView  %f_____滑动偏移:%f",[scrollView.panGestureRecognizer  velocityInView:scrollView].y,scrollView.contentOffset.y );
    //
    //    //    if(scrollView == _webView.scrollView)
    //    //    {
    //    //        if(scrollView.contentOffset.y >= maxHeight -20)
    //    //        {
    //    //            scrollView.scrollEnabled = NO;
    //    //        }
    //    //    }
    //
    if(scrollView == _table)
    {
        //                [_webView.scrollView setContentOffset:CGPointMake(0, _table.contentOffset.y + _webView.scrollView.contentOffset.y)];
        //        [_webView.scrollView performSelector:@selector(handlePan:) withObject:_table.panGestureRecognizer];
    }
    else
    {
        //            [_table setContentOffset:CGPointMake(0, -maxHeight +  scrollView.contentOffset.y)];
    }
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    *targetContentOffset = CGPointZero;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    if(scrollView == _webView.scrollView)
    //    {
    //        if(scrollView.contentOffset.y >= maxHeight)
    //        {
    //            scrollView.scrollEnabled = NO;
    //        }
    //    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //    if(scrollView == _webView.scrollView)
    //    {
    //        if(scrollView.contentOffset.y >= maxHeight)
    //        {
    //            scrollView.scrollEnabled = NO;
    //        }
    //    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2)
{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

@end
