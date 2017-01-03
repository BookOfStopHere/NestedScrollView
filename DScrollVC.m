//
//  DScrollVC.m
//  DScroll
//
//  Created by yang on 16/9/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "DScrollVC.h"

@implementation DScrollVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   _webView = [[QNUIWebView alloc] initWithFrame:self.view.bounds];
//    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.sDeleagte = self;
//    _webView.paginationMode = UIWebPaginationModeUnpaginated;
//    _webView.scrollView.contentOffset
    [self.view addSubview:_webView];
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_table];
    _table.delegate = self;
    _table.dataSource = self;
    
    [_table registerClass:UITableViewCell.class  forCellReuseIdentifier:@"class"];
    
    _table.tableHeaderView = _webView;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://www.qq.com"]]];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, _webView.scrollView.contentSize.height);
//    _table.tableHeaderView = _webView;
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
//        _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, webView.scrollView.contentSize.height);
//    _table.tableHeaderView = _webView;
//        [self addObserver:_webView.scrollView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    NSArray *su = _webView.scrollView.subviews;
    NSLog(@"");
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
    return cell;
}


- (void)matchScrollView:(UIScrollView *)first toScrollView:(UIScrollView *)second {
    CGPoint offset = first.contentOffset;
    offset.y = second.contentOffset.y;
    [first setContentOffset:offset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if([scrollView isEqual:_webView.scrollView])
    {
        [self matchScrollView:_table toScrollView:_webView.scrollView];
        _webView.scrollView.bounces = NO;
    }
    else
    {
        if(_table.contentOffset.y < 0)
        {
            CGPoint p = _webView.scrollView.contentOffset;
            [_webView.scrollView setContentOffset:CGPointMake(p.x, p.y + _table.contentOffset.y ) animated:YES];
        }
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
@end
