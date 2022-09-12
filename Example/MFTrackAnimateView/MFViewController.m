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

//@property (nonatomic, strong) UIView *item;
//@property (nonatomic, strong) MFTrackAnimateViewBaseAnimate *itemAnimate;
@property(nonatomic, strong) MFTrackAnimateViewRotateExpandView *rotateExpandView;

@end

@implementation MFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    self.item = [[UIView alloc] initWithFrame:CGRectMake(150, 300, 30, 30)];
//    self.item.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
//    self.item.layer.cornerRadius = 15;
//    self.item.clipsToBounds = YES;
//    [self.view addSubview:self.item];
//
//    CGFloat radius = 56.0;
//    CGFloat endRadius = M_PI*(radius/180.0);
//    CGFloat assistEndRadius = M_PI*((radius - 45.0)/180.0);
//    CGFloat corner = 80;
//    CGFloat assistLine = sqrt(corner * corner);
//    [self.item.layer removeAllAnimations];
//    CGPoint startPoint = CGPointMake(165, 315);
//    //绘制贝塞尔曲线
//    CGPoint endPoint = CGPointMake(startPoint.x + corner * sin(-endRadius), startPoint.y - corner * cos(-endRadius));
//    CGPoint controlPoint = CGPointMake(startPoint.x - assistLine * sin(assistEndRadius), startPoint.y - assistLine * cos(assistEndRadius));
//
////    UIBezierPath *movePath = [MFTrackAnimateViewBasePath bezierPathWithStartPoint:startPoint endPoint:endPoint anchorPoint:controlPoint];
//    UIBezierPath *movePath = [MFTrackAnimateViewBasePath circlePathWithCenterPoint:CGPointMake(115, 315) radius:50 startCircleAngle:0 stopCircleAngle:270 isDirectionClockwise:NO];
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = movePath.CGPath;
//    shapeLayer.lineWidth = 2;
//    shapeLayer.fillColor = [UIColor blackColor].CGColor;
//    [self.view.layer addSublayer:shapeLayer];
//
//    self.itemAnimate = MFTrackAnimateViewBaseAnimate.defaultAnimate
//            .setDuring(2)
//            .setPath(movePath.CGPath)
//            .setRemoveForwards(NO)
//            .setFillMode(MFTrackAnimateViewBaseAnimateFillModeStyleForwards)
//            .setRepeatCount(400)
//            .setDelay(2)
//            .setTimingFunction(MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseIn);
//    [self.item.layer addAnimation:self.itemAnimate.animate forKey:@"keyFrameAnimation"];

//    self.rotateExpandView = [[MFTrackAnimateViewRotateExpandView alloc] initWithFrame:CGRectMake(40, 200, 200, 200)];
//    [self.view addSubview:self.rotateExpandView];
//    self.rotateExpandView.backgroundColor = [UIColor colorWithRed:0.2 green:0.4 blue:0.4 alpha:1];
//    [self.rotateExpandView configureSubviews];

//    self.rotateExpandView = [MFTrackAnimateView rotateExpandViewWithFrame:CGRectMake(40, 200, 200, 200)
//                                                        rotateCenterPoint:CGPointMake(100, 100)
//                                                                   radius:50
//                                                                    delay:1
//                                                          circleAngleList:@[@(0), @(30), @(60), @(90), @(120), @(176)]
//                                                      distanceCircleAngle:75
//                                                     isDirectionClockwise:NO
//                                                               dataSource:self
//                                                        selectActionBlock:^(NSUInteger selectIndex) {
//                                                            NSLog(@"选中了: %ld", selectIndex);
//                                                        }];

    MFTrackAnimateViewRotateExpandViewConfigureModel *configureModel = [[MFTrackAnimateViewRotateExpandViewConfigureModel alloc] init];
    configureModel.rotateCenterPoint = CGPointMake(100, 100);
    configureModel.radius = 50;
    configureModel.delay = 1;
    configureModel.during = 1.5;
    configureModel.dismissDuring = 0.5;
    configureModel.circleAngleList = @[@(0), @(30), @(60), @(90), @(120), @(176)];
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

- (void)showAction {
    self.rotateExpandView.configureModel.delay = 0;
    [self.rotateExpandView showAction];
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
    [self.rotateExpandView dismissAction];
}


@end
