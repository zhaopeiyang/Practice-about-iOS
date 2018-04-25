//
//  ImageLayerViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/25.
//  Copyright © 2018年 ifeng. All rights reserved.
//
//  https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/2-寄宿图/寄宿图.md

#import "ImageLayerViewController.h"

@interface ImageLayerViewController ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation ImageLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"02.寄宿图";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.layerView];
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
