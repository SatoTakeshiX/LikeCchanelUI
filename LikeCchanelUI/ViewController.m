//
//  ViewController.m
//  LikeCchanelUI
//
//  Created by satoutakeshi on 2015/09/02.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIScrollView *myscroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myscroll.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)animationTransform:(UIView *)view duration:(float)duration delay:(float)delay {
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    //animation.beginTime = delay;
    //animation.autoreverses = YES;
    animation.repeatCount = 0;
    
    CATransform3D   transform;
    transform = CATransform3DIdentity;
    animation.fromValue = [NSValue valueWithCATransform3D:transform];
    
    transform = CATransform3DMakeRotation(M_PI, 1.0f, 0.0f, 0.0f);
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [view.layer addAnimation:animation forKey:@"transformAnimation"];
}

#pragma mark - ScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    CATransform3D transform = CATransform3DIdentity;
    
    float rotate = self.myscroll.contentOffset.y / 5;
    
    NSLog(@"rotateの値:%f",rotate);
    
    transform = CATransform3DRotate(transform, rotate * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    
    transform.m34 = 1.0f / -300.0f;
    
    rotate = rotate * 10;
    NSLog(@"10倍rotateの値:%f",rotate);
    transform = CATransform3DTranslate(transform, 1.0f, -rotate, 1000.0f);

    // topView に逆行列を適用する
    CATransform3D invertTransform = CATransform3DInvert(transform);
    
    self.topView.layer.transform = invertTransform;
    
}

@end
