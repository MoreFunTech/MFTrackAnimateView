//
// Created by Neal on 2022/9/12.
//

#import "MFTrackAnimateViewBaseAnimate.h"


@interface MFTrackAnimateViewBaseAnimate () <CAAnimationDelegate>

@property(nonatomic, strong) CAKeyframeAnimation *animate;
@property(nonatomic, assign) CFTimeInterval during;
@property(nonatomic, assign) CFTimeInterval delay;

@property(nonatomic) UIBezierPath *path;
@property(nonatomic) BOOL removedOnCompletion;
@property(nonatomic) int repeatCount;
@property(nonatomic) MFTrackAnimateViewBaseAnimateTimingFunctionStyle timingFunctionStyle;
@property(nonatomic) MFTrackAnimateViewBaseAnimateFillModeStyle fillMode;
@end

@implementation MFTrackAnimateViewBaseAnimate {
}

+ (__kindof MFTrackAnimateViewBaseAnimate *)defaultAnimate {
    MFTrackAnimateViewBaseAnimate *baseAnimate = [[MFTrackAnimateViewBaseAnimate alloc] init];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    baseAnimate.animate = animation;
    baseAnimate.animate.delegate = baseAnimate;
    return baseAnimate;
}


- (MFTrackAnimateViewBaseAnimate *(^)(CFTimeInterval))setDuring {
    __weak typeof(self) weakSelf = self;
    return ^(NSTimeInterval during) {
        weakSelf.animate.duration = during;
        weakSelf.during = during;
        return weakSelf;
    };
}

- (MFTrackAnimateViewBaseAnimate *(^)(CFTimeInterval))setDelay {
    __weak typeof(self) weakSelf = self;
    return ^(NSTimeInterval delay) {
        CFTimeInterval currentTime = CACurrentMediaTime();
        weakSelf.animate.beginTime = currentTime + delay;
        weakSelf.delay = delay;
        return weakSelf;
    };
}

- (MFTrackAnimateViewBaseAnimate *(^)(UIBezierPath *))setPath {
    __weak typeof(self) weakSelf = self;
    return ^(UIBezierPath * path) {
        weakSelf.animate.path = path.CGPath;
        weakSelf.path = path;
        return weakSelf;
    }; 
}

- (MFTrackAnimateViewBaseAnimate *(^)(BOOL))setRemoveOnComplete {
    __weak typeof(self) weakSelf = self;
    return ^(BOOL removeOnComplete) {
        weakSelf.animate.removedOnCompletion = removeOnComplete;
        weakSelf.removedOnCompletion = removeOnComplete;
        return weakSelf;
    };
}

- (MFTrackAnimateViewBaseAnimate *(^)(int))setRepeatCount {
    __weak typeof(self) weakSelf = self;
    return ^(int repeatCount) {
        weakSelf.animate.repeatCount = repeatCount;
        weakSelf.repeatCount = repeatCount;
        return weakSelf;
    }; 
}

- (MFTrackAnimateViewBaseAnimate *(^)(MFTrackAnimateViewBaseAnimateFillModeStyle))setFillMode {
    __weak typeof(self) weakSelf = self;
    return ^(MFTrackAnimateViewBaseAnimateFillModeStyle fillModeStyle) {
        if (fillModeStyle == MFTrackAnimateViewBaseAnimateFillModeStyleForwards) {
            weakSelf.animate.fillMode = kCAFillModeForwards;
        } else if (fillModeStyle == MFTrackAnimateViewBaseAnimateFillModeStyleBackwards) {
            weakSelf.animate.fillMode = kCAFillModeBackwards;
        } else if (fillModeStyle == MFTrackAnimateViewBaseAnimateFillModeStyleBoth) {
            weakSelf.animate.fillMode = kCAFillModeBoth;
        } else if (fillModeStyle == MFTrackAnimateViewBaseAnimateFillModeStyleRemoved) {
            weakSelf.animate.fillMode = kCAFillModeRemoved;
        }
        weakSelf.fillMode = fillModeStyle;
        return weakSelf;
    };
}

- (MFTrackAnimateViewBaseAnimate *(^)(MFTrackAnimateViewBaseAnimateTimingFunctionStyle))setTimingFunction {
    __weak typeof(self) weakSelf = self;
    return ^(MFTrackAnimateViewBaseAnimateTimingFunctionStyle timingFunctionStyle) {
        if (timingFunctionStyle == MFTrackAnimateViewBaseAnimateTimingFunctionStyleDefault) {
            weakSelf.animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        } else if (timingFunctionStyle == MFTrackAnimateViewBaseAnimateTimingFunctionStyleLiner) {
            weakSelf.animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        } else if (timingFunctionStyle == MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseIn) {
            weakSelf.animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        } else if (timingFunctionStyle == MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseOut) {
            weakSelf.animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        } else if (timingFunctionStyle == MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseInEaseOut) {
            weakSelf.animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        }
        weakSelf.timingFunctionStyle = timingFunctionStyle;
        return weakSelf;
    };
}

#pragma mark - Animation Delegate

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
    if (self.didAnimateStartActionBlock) {
        self.didAnimateStartActionBlock(self.path.currentPoint);
    }
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.didAnimateStopActionBlock) {
        self.didAnimateStopActionBlock(self.path.currentPoint);
    } 
}


@end