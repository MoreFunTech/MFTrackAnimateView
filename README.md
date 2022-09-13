# MFTrackAnimateView

[![CI Status](https://img.shields.io/travis/NealWills/MFTrackAnimateView.svg?style=flat)](https://travis-ci.org/NealWills/MFTrackAnimateView)
[![Version](https://img.shields.io/cocoapods/v/MFTrackAnimateView.svg?style=flat)](https://cocoapods.org/pods/MFTrackAnimateView)
[![License](https://img.shields.io/cocoapods/l/MFTrackAnimateView.svg?style=flat)](https://cocoapods.org/pods/MFTrackAnimateView)
[![Platform](https://img.shields.io/cocoapods/p/MFTrackAnimateView.svg?style=flat)](https://cocoapods.org/pods/MFTrackAnimateView)

## Installation

MFTrackAnimateView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MFTrackAnimateView'
```

## Using

``` Objective-c

#import <MFTrackAnimateView/MFTrackAnimateView.h>

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


```

## Author

NealWills, NealWills93@gmail.com

## License

MFTrackAnimateView is available under the MIT license. See the LICENSE file for more info.
