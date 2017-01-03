//
//  ViewController.m
//  DScroll
//
//  Created by yang on 16/9/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "ViewController.h"
#import "DScrollVC.h"
#import "HeaderScrollViewController.h"
#import "SubMixViewController.h"
#import "TESTViewController.h"
#import "SWXTViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
//    DScrollVC *c = DScrollVC.new;
//    [self.view addSubview:c.view];
//    [self addChildViewController:c];return;
//    SWXTViewController *sx = SWXTViewController.new;
//    [self.view addSubview:sx.view];
//    [self addChildViewController:sx]; return;
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"key_Theme_bottom_update_time_stamp"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    SubMixViewController *mix = SubMixViewController.new;
    [self.view addSubview:mix.view];
    [self addChildViewController:mix]; return;
    
//    TESTViewController *kk =  TESTViewController.new;
//        [self.view addSubview:kk.view];
//        [self addChildViewController:kk];
//
//    
//    HeaderScrollViewController *h = HeaderScrollViewController.new;
//    [self.view addSubview:h.view];
//    [self addChildViewController:h];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
