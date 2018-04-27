//
//  GeometryLayerViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/26.
//  Copyright © 2018年 ifeng. All rights reserved.
//
//  https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/3-图层几何学/图层几何学.md

#import "GeometryLayerViewController.h"

@interface GeometryLayerViewController ()
{
    NSTimer *_timer;
}

@property (nonatomic, strong) CALayer *timerBgLayer;
@property (nonatomic, strong) CALayer *hourHand;
@property (nonatomic, strong) CALayer *minuteHand;
@property (nonatomic, strong) CALayer *secondHand;

@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) CALayer *whiteLayer;
@property (nonatomic, strong) CALayer *blueLayer;
@property (nonatomic, strong) CALayer *yellowLayer;

@end

@implementation GeometryLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // TODO: anchorPoint
    [self.view.layer addSublayer:self.timerBgLayer];
    [self.timerBgLayer addSublayer:self.hourHand];
    [self.timerBgLayer addSublayer:self.minuteHand];
    [self.timerBgLayer addSublayer:self.secondHand];
    
    self.hourHand.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHand.anchorPoint = CGPointMake(0.5, 0.9);
    self.secondHand.anchorPoint = CGPointMake(0.5, 0.9);
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
    
    // TODO: zPosition
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.redView];
    
    self.greenView.layer.zPosition = 1.0f;
    
    
    [self.view.layer addSublayer:self.whiteLayer];
    [self.whiteLayer addSublayer:self.blueLayer];
    [self.whiteLayer addSublayer:self.yellowLayer];
    
    self.blueLayer.zPosition = 1.0f;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - Events
- (void)tick
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = (components.second / 60.0) * M_PI *2.0;
    
    self.hourHand.affineTransform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(secsAngle);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    NSLog(@"%@, %@", self.view.subviews, self.view.layer.sublayers);
    
#pragma mark - containsPoint:
//    CGPoint point1 = [self.whiteLayer convertPoint:point fromLayer:self.view.layer];
//    CGPoint point1 = [self.view.layer convertPoint:point toLayer:self.whiteLayer];
//
//    if ([self.whiteLayer containsPoint:point1]) {
//        point1 = [self.blueLayer convertPoint:point1 fromLayer:self.whiteLayer];
//        if ([self.blueLayer containsPoint:point1]) {
//            NSLog(@"Inside Blue Layer!");
//        } else {
//            NSLog(@"Inside White Layer!");
//        }
//    }
    
#pragma mark - hitTest:
    
    CALayer *layer = [self.view.layer hitTest:point];
    if (layer == self.blueLayer) {
        NSLog(@"Inside Blue Layer!");
    }
    
    if (layer == self.yellowLayer) {
        NSLog(@"Inside Yellow Layer!");
    }
    
    if (layer == self.whiteLayer) {
        NSLog(@"Inside White Layer!");
    }
    
    if (layer == self.greenView.layer) {
        NSLog(@"Inside Green Layer!");
    }
    
    if (layer == self.redView.layer) {
        NSLog(@"Inside Red Layer!");
    }
}

// TODO: 自动布局
/**
 当使用视图的时候，可以充分利用UIView类接口暴露出来的UIViewAutoresizingMask和NSLayoutConstraintAPI，但如果想随意控制CALayer的布局，就需要手工操作。最简单的方法就是使用CALayerDelegate如下函数：
 
 - (void)layoutSublayersOfLayer:(CALayer *)layer;
 当图层的bounds发生改变，或者图层的-setNeedsLayout方法被调用的时候，这个函数将会被执行。这使得你可以手动地重新摆放或者重新调整子图层的大小，但是不能像UIView的autoresizingMask和constraints属性做到自适应屏幕旋转。
 
 这也是为什么最好使用视图而不是单独的图层来构建应用程序的另一个重要原因之一。
 */

#pragma mark - Getters
- (CALayer *)timerBgLayer
{
    if (nil == _timerBgLayer) {
        _timerBgLayer = [CALayer layer];
        _timerBgLayer.frame = CGRectMake(20, 80, 300, 300);
        UIImage *image = [UIImage imageNamed:@"timer_bg"];
        _timerBgLayer.contents = (__bridge id)image.CGImage;
        _timerBgLayer.contentsScale = image.scale;
        _timerBgLayer.contentsGravity = @"center";
    }
    return _timerBgLayer;
}

- (CALayer *)hourHand
{
    if (nil == _hourHand) {
        _hourHand = [CALayer layer];
        _hourHand.frame = CGRectMake(0, 0, 6, 80);
        _hourHand.backgroundColor = [UIColor blueColor].CGColor;
        _hourHand.position = CGPointMake(self.timerBgLayer.bounds.size.width / 2, self.timerBgLayer.bounds.size.height / 2);
    }
    return _hourHand;
}

- (CALayer *)minuteHand
{
    if (nil == _minuteHand) {
        _minuteHand = [CALayer layer];
        _minuteHand.frame = CGRectMake(0, 0, 4, 120);
        _minuteHand.backgroundColor = [UIColor greenColor].CGColor;
        _minuteHand.position = self.hourHand.position;
    }
    return _minuteHand;
}

- (CALayer *)secondHand
{
    if (nil == _secondHand) {
        _secondHand = [CALayer layer];
        _secondHand.frame = CGRectMake(0, 0, 2, 130);
        _secondHand.backgroundColor = [UIColor redColor].CGColor;
        _secondHand.position = self.hourHand.position;
    }
    return _secondHand;
}

- (UIView *)greenView
{
    if (nil == _greenView) {
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 100, 100)];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (UIView *)redView
{
    if (nil == _redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(80, 450, 100, 100)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (CALayer *)whiteLayer
{
    if (nil == _whiteLayer) {
        _whiteLayer = [CALayer layer];
        _whiteLayer.frame = CGRectMake(200, 400, 200, 200);
        _whiteLayer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return _whiteLayer;
}

- (CALayer *)blueLayer
{
    if (nil == _blueLayer) {
        _blueLayer = [CALayer layer];
        _blueLayer.frame = CGRectMake(50, 50, 100, 100);
        _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _blueLayer;
}

- (CALayer *)yellowLayer
{
    if (nil == _yellowLayer) {
        _yellowLayer = [CALayer layer];
        _yellowLayer.frame = CGRectMake(10, 10, 80, 80);
        _yellowLayer.backgroundColor = [UIColor yellowColor].CGColor;
    }
    return _yellowLayer;
}

@end
