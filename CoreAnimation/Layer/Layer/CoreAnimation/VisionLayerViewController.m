//
//  VisionLayerViewController.m
//  Layer
//
//  Created by ifeng on 2018/4/26.
//  Copyright © 2018年 ifeng. All rights reserved.
//

#import "VisionLayerViewController.h"

@interface VisionLayerViewController ()

@end

@implementation VisionLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"04.视觉效果";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // TODO: conrnerRadius masksToBounds borderWidth borderColor
    
    // TODO: shadowOpacity shadowColor shadowOffset shadowRadius
    
    // TODO: shadowPath
    
    // TODO: mask 图层蒙版
    /**
     如果mask图层比父图层要小，只有在mask图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。
     CALayer蒙板图层真正厉害的地方在于蒙板图不局限于静态图。任何有图层构成的都可以作为mask属性，这意味着你的蒙板可以通过代码甚至是动画实时生成。
     */
    
    // TODO: 拉伸过滤 minificationFilter magnificationFilter
    /**
     对于比较小的图或者是差异特别明显，极少斜线的大图，最近过滤算法会保留这种差异明显的特质以呈现更好的结果。但是对于大多数的图尤其是有很多斜线或是曲线轮廓的图片来说，最近过滤算法会导致更差的结果。换句话说，线性过滤保留了形状，最近过滤则保留了像素的差异。
     */
}

@end
