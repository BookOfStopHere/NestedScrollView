//
//  DScrollVC.m
//  DScroll
//
//  Created by yang on 16/9/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "DScrollVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
static void *sconetext = &sconetext;
static void *oconetext = &oconetext;
@implementation DScrollVC
{
    CGFloat maxHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   _webView = [[QNUIWebView alloc] initWithFrame:self.view.bounds];
//    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.sDeleagte = self;
    _webView.backgroundColor = [UIColor clearColor];
//    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,self.view.bounds.size.height - 100, 0);
    _webView.scrollView.bounces = NO;
//    _webView.scrollView.showsVerticalScrollIndicator = NO;
//    _webView.paginationMode = UIWebPaginationModeUnpaginated;
//    _webView.scrollView.scrollEnabled = NO;
//    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:sconetext];
//    [_webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:oconetext];
   
    [self.view addSubview:_webView];
    _table = [[TT alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.backgroundColor = [UIColor clearColor];
//    [self.view insertSubview:_table belowSubview:_webView];
    [self.view addSubview:_table];
//    [self.view insertSubview:_table belowSubview:_webView];
    _table.contentInset = UIEdgeInsetsMake(self.view.bounds.size.height-100, 0, 0, 0);
    _table.delegate = self;
    _table.dataSource = self;
    
    [_table registerClass:UITableViewCell.class  forCellReuseIdentifier:@"class"];
    
//    _table.tableHeaderView = _webView;
    
    [_webView.scrollView.panGestureRecognizer addTarget:_table action:@selector(handlePan:)];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5NTUxOTc4Mw==&mid=2650453655&idx=1&sn=e71a78408e68a64b7c68be4851a908c3"]]];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if(context == sconetext)
    {
        CGSize size = [change[NSKeyValueChangeOldKey] CGSizeValue];
        CGSize nsize = [change[NSKeyValueChangeNewKey] CGSizeValue];
        maxHeight = nsize.height;
         [_table beginUpdates];
        _table.contentInset = UIEdgeInsetsMake(nsize.height, 0, 0, 0);
         [_table endUpdates];
        CGRect frame = _webView.frame;
        frame.size.height = nsize.height > self.view.bounds.size.height ? self.view.bounds.size.height : nsize.height;
        _webView.frame = frame;
        [_table beginUpdates];
//        _table.tableHeaderView = _webView;
        [_table endUpdates];
        NSLog(@"");
    }
//    if(context == oconetext)
//    {
//        CGPoint point = [change[NSKeyValueChangeOldKey] CGPointValue];
//        CGPoint npoint = [change[NSKeyValueChangeNewKey] CGPointValue];
//        NSLog(@"####____%f_____%f\n",_webView.scrollView.contentSize.height,npoint.y);
//        
//        [_table setContentOffset:CGPointMake(0, -maxHeight +  npoint.y) animated:NO];
//    }
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
     [webView stringByEvaluatingJavaScriptFromString:@"document.addEventListener(\"DOMMouseScroll\" ,scrollFunction, false); function scrollFunction () {console.log('scrolllllllsdkjajdjkajdjka');}"];
   NSString *hStr =  [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
    NSLog(@"");
    
    CGRect frame;// = _webView.frame;
    frame.size.height =  MIN([hStr floatValue],_webView.scrollView.contentSize.height);
    maxHeight = frame.size.height;
//     frame.size.height = frame.size.height > self.view.bounds.size.height ? self.view.bounds.size.height : frame.size.height;
    
     [_table beginUpdates];
    _table.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
     [_table endUpdates];
//    _webView.frame = frame;
    [_table beginUpdates];
//    _table.tableHeaderView = _webView;
    [_table endUpdates];
    
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


- (void)matchScrollView:(UIScrollView *)first toScrollView:(UIScrollView *)second {
    CGPoint offset = first.contentOffset;
    offset.y = second.contentOffset.y;
    [first setContentOffset:offset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
//    if(scrollView == _webView.scrollView)
//    {
//        if(scrollView.contentOffset.y >= maxHeight -20)
//        {
//            scrollView.scrollEnabled = NO;
//        }
//    }
    
//    if(scrollView == _table)
//    {
//        [_webView.scrollView setContentOffset:CGPointMake(0, _table.contentOffset.y + maxHeight)];
//    }
//    else
//    {
//        [_table setContentOffset:CGPointMake(0, -maxHeight +  scrollView.contentOffset.y)];
//    }
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
