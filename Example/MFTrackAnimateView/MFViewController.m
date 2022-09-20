//
//  MFViewController.m
//  MFTrackAnimateView
//
//  Created by NealWills on 08/05/2022.
//  Copyright (c) 2022 NealWills. All rights reserved.
//

#import "MFViewController.h"
#import "MFViewItem.h"

#import <MFTrackAnimateView/MFTrackAnimateView.h>

@interface MFViewController () <MFTrackAnimateViewRotateExpandViewDataSource>

@property(nonatomic, strong) UIView *item0;
@property(nonatomic, strong) UIView *item1;
//@property (nonatomic, strong) MFTrackAnimateViewBaseAnimate *itemAnimate;
@property(nonatomic, strong) MFTrackAnimateViewRotateExpandView *rotateExpandView;
@property(nonatomic, strong) MFTrackAnimateViewNormalExpandView *normalExpandView;

@end

@implementation MFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self configureItemView];

    [self configureTrackView];
//    [self configureNormalTrackView];

}

- (void)configureItemView {
    self.item0 = [[UIView alloc] initWithFrame:CGRectMake(150, 300, 30, 30)];
    self.item0.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
    self.item0.layer.cornerRadius = 15;
    self.item0.clipsToBounds = YES;
    [self.view addSubview:self.item0];

    self.item1 = [[UIView alloc] initWithFrame:CGRectMake(150, 400, 30, 30)];
    self.item1.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
    self.item1.layer.cornerRadius = 15;
    self.item1.clipsToBounds = YES;
    [self.view addSubview:self.item1];


//
    CFTimeInterval currentTime = CACurrentMediaTime();
    CGFloat radius = 56.0;
    CGFloat endRadius = M_PI * (radius / 180.0);
    CGFloat assistEndRadius = M_PI * ((radius - 45.0) / 180.0);
    CGFloat corner = 80;
    CGFloat assistLine = sqrt(corner * corner);
    [self.item0.layer removeAllAnimations];
    CGPoint startPoint = CGPointMake(165, 315);
    //绘制贝塞尔曲线
    CGPoint endPoint = CGPointMake(startPoint.x + corner * sin(-endRadius), startPoint.y - corner * cos(-endRadius));
    CGPoint controlPoint = CGPointMake(startPoint.x - assistLine * sin(assistEndRadius), startPoint.y - assistLine * cos(assistEndRadius));

    UIBezierPath *movePath0 = [MFTrackAnimateViewBasePath bezierPathWithStartPoint:startPoint endPoint:endPoint anchorPoint:controlPoint];
    UIBezierPath *movePath1 = [MFTrackAnimateViewBasePath circlePathWithCenterPoint:CGPointMake(115, 415) radius:50 startCircleAngle:0 stopCircleAngle:270 isDirectionClockwise:NO];

    {
        //关键帧动画
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyFrameAnimation.duration = 2;
        keyFrameAnimation.path = movePath0.CGPath;
        keyFrameAnimation.removedOnCompletion = NO;
        keyFrameAnimation.fillMode = kCAFillModeForwards;
        keyFrameAnimation.repeatCount = 9999;
        keyFrameAnimation.beginTime = currentTime + 0.5;
        keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.item0.layer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation"];

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = movePath0.CGPath;
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = nil;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        [self.view.layer addSublayer:shapeLayer];
    }
    {
        //关键帧动画
        CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyFrameAnimation.duration = 2;
        keyFrameAnimation.path = movePath1.CGPath;
        keyFrameAnimation.removedOnCompletion = NO;
        keyFrameAnimation.fillMode = kCAFillModeForwards;
        keyFrameAnimation.repeatCount = 9999;
        keyFrameAnimation.beginTime = currentTime + 0.5;
        keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [self.item1.layer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation1"];

        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = movePath1.CGPath;
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = nil;
        shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        [self.view.layer addSublayer:shapeLayer];
    }
}

- (void)configureTrackView {
    MFTrackAnimateViewRotateExpandViewConfigureModel *configureModel = [[MFTrackAnimateViewRotateExpandViewConfigureModel alloc] init];
    configureModel.rotateCenterPoint = CGPointMake(100, 100);
    configureModel.radius = 50;
    configureModel.delay = 1;
    configureModel.during = 1.5;
    configureModel.dismissDuring = 0.5;
    configureModel.circleAngleList = @[@(80), @(30), @(60), @(90), @(120), @(176), @(320)];
    configureModel.distanceCircleAngle = 75;
    configureModel.isDirectionClockwise = NO;
    self.rotateExpandView = [MFTrackAnimateView rotateExpandViewWithFrame:CGRectMake(40, 200, 200, 200) configureModel:configureModel dataSource:self];
    [self.view addSubview:self.rotateExpandView];
    self.rotateExpandView.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
    [self.rotateExpandView configureSubviews];
    self.rotateExpandView.didAnimateStopBlock = ^(BOOL isShowAnimate) {
        if (isShowAnimate) {
            NSLog(@"弹出动画执行完毕");
        } else {
            NSLog(@"消失动画执行完毕");
        }
    };

    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 80, 40)];
    showButton.backgroundColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:1];
    [showButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    showButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:showButton];
    [showButton setTitle:@"show" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureNormalTrackView {

    self.normalExpandView = [MFTrackAnimateView normalExpandViewWithFrame:CGRectMake(40, 200, 200, 200) dataSource:self];
    [self.view addSubview:self.normalExpandView];
    self.normalExpandView.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
    [self.normalExpandView configureSubviews];
    self.normalExpandView.didAnimateStopBlock = ^(BOOL isShowAnimate) {
        if (isShowAnimate) {
            NSLog(@"弹出动画执行完毕");
        } else {
            NSLog(@"消失动画执行完毕");
        }
    };

    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 80, 40)];
    showButton.backgroundColor = [UIColor colorWithRed:0.4 green:0.3 blue:0.2 alpha:1];
    [showButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    showButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:showButton];
    [showButton setTitle:@"show" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showAction {
    if (_rotateExpandView) {
        self.rotateExpandView.configureModel.delay = 0;
        [self.rotateExpandView showAction];
    }
    if (_normalExpandView) {
        [self.normalExpandView showAction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *)itemForRowAtIndex:(NSUInteger)index {
    return [[MFViewItem alloc] init];
}

- (CGSize)sizeForRowAtIndex:(NSUInteger)index {
    return CGSizeMake(30, 30);
}

- (void)didItemSelectWithIndex:(NSUInteger)index {
    NSLog(@"代理选中了: %ld", index);
    if (_rotateExpandView) {
        [self.rotateExpandView dismissAction];
    }
    if (_normalExpandView) {
        [self.normalExpandView dismissAction];
    }
}

- (MFTrackAnimateViewBasePathConfigureModel *)pathConfigureForRowIndex:(NSUInteger)index originPathConfigure:(MFTrackAnimateViewBasePathConfigureModel *)originPathConfigure {
    if (index == 0) {


        originPathConfigure.pathStyle = MFTrackAnimateViewBasePathConfigureModelPathStyleAnchorPointBezier;
        originPathConfigure.startPoint = CGPointMake(100, 100);
        originPathConfigure.stopPoint = CGPointMake(50, 50);
        originPathConfigure.anchorPoint0 = CGPointMake(100, 50);
        originPathConfigure.during = 2;
        return originPathConfigure;
    }
   if (index == 1) {


        originPathConfigure.pathStyle = MFTrackAnimateViewBasePathConfigureModelPathStyleAnchorPointBezier;
        originPathConfigure.startPoint = CGPointMake(100, 100);
        originPathConfigure.stopPoint = CGPointMake(150, 50);
        originPathConfigure.anchorPoint0 = CGPointMake(100, 50);
        originPathConfigure.during = 2;
        return originPathConfigure;
    }
    originPathConfigure.pathStyle = MFTrackAnimateViewBasePathConfigureModelPathStyleAnchorPointBezier;
    originPathConfigure.startPoint = CGPointMake(100, 100);
    originPathConfigure.stopPoint = CGPointMake(150, 50);
    originPathConfigure.anchorPoint0 = CGPointMake(100, 50);
    originPathConfigure.during = 2;
    return originPathConfigure;

}

- (NSUInteger)numberOfItemTrackView {
    return 2;
}

@end
