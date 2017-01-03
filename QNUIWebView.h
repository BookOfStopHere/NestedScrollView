//
//  QNUIWebView.h
//  DScroll
//
//  Created by yang on 16/9/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QNUIWebViewDelegate <UIScrollViewDelegate>
@optional

@end

@interface QNUIWebView : UIWebView
@property (nonatomic, weak) id<QNUIWebViewDelegate> sDeleagte;
@end
