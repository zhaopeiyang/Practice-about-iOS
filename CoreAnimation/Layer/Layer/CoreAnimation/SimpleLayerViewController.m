//
//  SimpleLayerViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/25.
//  Copyright © 2018年 ifeng. All rights reserved.
//
//  https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/1-图层树/图层树.md

#import "SimpleLayerViewController.h"

@interface SimpleLayerViewController ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation SimpleLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.layerView];
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.layerView.layer addSublayer:blueLayer];
}

- (UIView *)layerView
{
    if (nil == _layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _layerView.center = self.view.center;
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    return _layerView;
}

@end
