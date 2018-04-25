//
//  ImageLayerViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/25.
//  Copyright © 2018年 ifeng. All rights reserved.
//
//  https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/2-寄宿图/寄宿图.md

#import "ImageLayerViewController.h"

@interface ImageLayerViewController ()<CALayerDelegate>

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation ImageLayerViewController

- (void)dealloc
{
    // TODO: 将blueLayer的代理设为nil，否则在pop回上一页面时，会导致崩溃。
    self.blueLayer.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"02.寄宿图";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.layerView];
    
    
    UIImage *image = [UIImage imageNamed:@"player_alert_icon"];
    
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    // TODO: contentsGravity 决定了内容在图层边界的对齐方式
    self.layerView.layer.contentsGravity = @"center";
    
    // TODO: contentsScale 定义了寄宿图的像素尺寸和视图大小的比例
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale; // image.scale;
    
    // TODO: masksToBounds
//    self.layerView.layer.masksToBounds = YES;
    
    // TODO: contentsRect 允许在图层的边框里显示寄宿图的一个子域； 用处之一是使用image sprites（图片拼合）。
    self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    
    // TODO: contentsCenter 定义了图层中的可拉伸区域和一个固定的边框。可以运用到任何寄宿图，甚至包括在Core Graphics运行时绘制的图形。
    
    
#pragma mark - Custome Drawing（给contents赋CGImage的值不是唯一的设置寄宿图的方法。）
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 100, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:blueLayer];

    blueLayer.delegate = self;
    
    [blueLayer display];
    
    self.blueLayer = blueLayer;
}

#pragma mark - CALayerDelegate
/**
 当需要被重绘时，CALayer会请求它的代理给它一个寄宿图来显示。它通过调用下面这个方法做到的:
 - (void)displayLayer:(CALayer *)layer;
 趁着这个机会，如果代理想直接设置contents属性的话，它就可以这么做，不然没有别的方法可以调用了。
 
 如果代理不实现-displayLayer:方法，CALayer就会转而尝试调用下面这个方法：
 - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
 在调用这个方法之前，CALayer创建了一个合适尺寸的空寄宿图（尺寸由bounds和contentsScale决定）和一个Core Graphics的绘制上下文环境，为绘制寄宿图做准备，它作为ctx参数传入。
 */
//- (void)displayLayer:(CALayer *)layer
//{
//    UIImage *image = [UIImage imageNamed:@"player_alert_icon"];
//
//    layer.contents = (__bridge id)image.CGImage;
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}
/**
 注意一下一些有趣的事情：
 1. 我们在blueLayer上显式地调用了-display。不同于UIView，当图层显示在屏幕上时，CALayer不会自动重绘它的内容。它把重绘的决定权交给了开发者。
 2. 尽管我们没有用masksToBounds属性，绘制的那个圆仍然沿边界被裁剪了。这是因为当你使用CALayerDelegate绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持。
 */

#pragma mark - Getters
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

#pragma mark - 图片拼合优缺点
/*
 通常，多张图片可以拼合后打包整合到一张大图上一次性载入。相比多次载入不同的图片，这样做能够带来很多方面的好处：内存使用，载入时间，渲染性能等等
 
 拼合不仅减小了应用程序的大小，还有效地提高了载入性能（单张大图比多张小图载入得更快），但是手动排列可能很麻烦，如果你需要在一个已经创建好的拼合图上做一些尺寸上的修改或者其他变动，无疑是比较麻烦的。
 
 Mac上有一些商业软件可以为你自动拼合图片，这些工具自动生成一个包含拼合后的坐标的XML或者plist文件，拼合图片的使用大大简化。这个文件可以和图片一同载入，并给每个拼合的图层设置contentsRect，这样开发者就不用手动写代码来摆放位置了。
 
 这些文件通常在OpenGL游戏中使用，不过呢，你要是有兴趣在一些常见的app中使用拼合技术的话，有一个叫做LayerSprites的开源库（https://github.com/nicklockwood/LayerSprites)，它能够读取Cocos2D格式中的拼合图并在普通的Core Animation层中显示出来。
 */
