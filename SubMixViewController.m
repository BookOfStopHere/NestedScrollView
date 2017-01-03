//
//  SubMixViewController.m
//  DScroll
//
//  Created by yang on 16/10/8.
//  Copyright © 2016年 yang. All rights reserved.
//
//貌似这个最流弊
//牛逼
#import <JavaScriptCore/JavaScriptCore.h>
#import "SubMixViewController.h"
#import "UIView+GES.h"
#import "MTableView.h"
#import "QNUIWebView.h"

@interface SubMixViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@end
static void *sconetext = &sconetext;
static void *oconetext = &oconetext;
@implementation SubMixViewController
{
    CGFloat maxHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[QNUIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) ];

    //    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    _webView.sDeleagte = self;
    _webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
    
    _table = [[MTableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height /2, self.view.bounds.size.width, self.view.bounds.size.height/2) style:UITableViewStylePlain];
    _table.backgroundColor = [UIColor clearColor];
    _table.pagingEnabled =NO;
    [self.view addSubview:_table];
    _table.bouncesZoom = NO;
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:UITableViewCell.class  forCellReuseIdentifier:@"class"];
    
            [_table addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:oconetext];
    [_webView.scrollView.panGestureRecognizer addTarget:self  action:@selector(handlePan:)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://36kr.com/"]]];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        if(scrollView == _webView.scrollView)
        {

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
    if(scrollView == _webView.scrollView)
    {
              *targetContentOffset = CGPointZero;
//        [_table setContentOffset:CGPointMake(0, _table.contentOffset.y + ((*targetContentOffset).y - scrollView.contentOffset.y)) animated:YES];
    }
    else
    {
//        [_webView.scrollView setContentOffset:CGPointMake(0, _webView.scrollView.contentOffset.y + ((*targetContentOffset).y - scrollView.contentOffset.y)) animated:YES];
         *targetContentOffset = CGPointZero;
    }

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if(context == oconetext)
    {
        CGPoint point = [change[NSKeyValueChangeOldKey] CGPointValue];
        CGPoint npoint = [change[NSKeyValueChangeNewKey] CGPointValue];
        [_webView.scrollView setContentOffset:CGPointMake(0, _webView.scrollView.contentOffset.y + (npoint.y - point.y)) animated:NO];
//        NSLog(@"PageLoaing %d\n",_webView.isLoading);
        
//   [_table setContentOffset:CGPointMake(0, _table.contentOffset.y + (npoint.y - point.y)) animated:NO];
    }
    
}


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
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2)
{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
