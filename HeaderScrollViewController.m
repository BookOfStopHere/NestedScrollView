//
//  HeaderScrollViewController.m
//  DScroll
//
//  Created by yang on 16/9/25.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "HeaderScrollViewController.h"
static void *sconetext = &sconetext;
static void *oconetext = &oconetext;
@interface HeaderScrollViewController ()

@end

@implementation HeaderScrollViewController
{
    CGFloat maxHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[QNUIWebView alloc] initWithFrame:self.view.bounds];
    //    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.sDeleagte = self;
    _webView.backgroundColor = [UIColor clearColor];
//    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,self.view.bounds.size.height, 0);
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,self.view.bounds.size.height/2, 0);
    _webView.scrollView.bounces = NO;
    //    _webView.scrollView.showsVerticalScrollIndicator = NO;
    //    _webView.paginationMode = UIWebPaginationModeUnpaginated;
    //    _webView.scrollView.scrollEnabled = NO;
//    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:sconetext];
//    [_webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:oconetext];
    
//    [self.view addSubview:_webView];
    _table = [[TT alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.backgroundColor = [UIColor clearColor];
    //    [self.view insertSubview:_table belowSubview:_webView];
    [self.view addSubview:_table];
    //    [self.view insertSubview:_table belowSubview:_webView];
//    _table.contentInset = UIEdgeInsetsMake(self.view.bounds.size.height/2, 0, 0, 0);
    _table.delegate = self;
    _table.dataSource = self;
    
    [_table registerClass:UITableViewCell.class  forCellReuseIdentifier:@"class"];
    
    _table.tableHeaderView = _webView;
    
    
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL  URLWithString:@"http://www.qq.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
                _table.tableHeaderView = _webView;
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
//    [webView stringByEvaluatingJavaScriptFromString:@"document.addEventListener(\"DOMMouseScroll\" ,scrollFunction, false); function scrollFunction () {console.log('scrolllllllsdkjajdjkajdjka');}"];
//    NSString *hStr =  [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
//    NSLog(@"");
//    
//    CGRect frame = _webView.frame;
//    frame.size.height =  MIN([hStr floatValue],_webView.scrollView.contentSize.height);
//    maxHeight = frame.size.height;
//    frame.size.height = frame.size.height > self.view.bounds.size.height ? self.view.bounds.size.height : frame.size.height;
//    
//    [_table beginUpdates];
//    _table.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
//    [_table endUpdates];
//    _webView.frame = frame;
//    [_table beginUpdates];
//        _table.tableHeaderView = _webView;
//    [_table endUpdates];
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
    //    cell.layer.borderWidth = 2.0;
    return cell;
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
