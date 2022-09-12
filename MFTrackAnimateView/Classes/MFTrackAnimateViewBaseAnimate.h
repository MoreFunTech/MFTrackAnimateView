//
// Created by Neal on 2022/9/12.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MFTrackAnimateViewBaseAnimateTimingFunctionStyle) {
    MFTrackAnimateViewBaseAnimateTimingFunctionStyleDefault = 0,
    MFTrackAnimateViewBaseAnimateTimingFunctionStyleLiner = 1,
    MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseIn = 2,
    MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseOut = 3,
    MFTrackAnimateViewBaseAnimateTimingFunctionStyleEaseInEaseOut = 4,
};

typedef NS_ENUM(NSInteger, MFTrackAnimateViewBaseAnimateFillModeStyle) {
    MFTrackAnimateViewBaseAnimateFillModeStyleForwards = 0,
    MFTrackAnimateViewBaseAnimateFillModeStyleBackwards = 1,
    MFTrackAnimateViewBaseAnimateFillModeStyleBoth = 2,
    MFTrackAnimateViewBaseAnimateFillModeStyleRemoved = 3,
};



@interface MFTrackAnimateViewBaseAnimate : NSObject

+ (__kindof MFTrackAnimateViewBaseAnimate *)defaultAnimate;

@property(nonatomic, strong, readonly) CAKeyframeAnimation *animate;

/**
 * 设置动画持续时间（单次）
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setDuring)(CFTimeInterval during);

/**
 * 设置动画延迟执行时间
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setDelay)(CFTimeInterval delay);

/**
 * 设置动画轨道路径
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setPath)(UIBezierPath *path);

/**
 * 设置动画结束立即清除动画
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setRemoveOnComplete)(BOOL removeOnComplete);

/**
 * 动画重复次数
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setRepeatCount)(int repeatCount);

/**
 * fillMode 动画执行完回到初始状态
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setFillMode)(MFTrackAnimateViewBaseAnimateFillModeStyle fillMode);

/**
 * 动画变化趋势
 */
@property (nonatomic, copy) MFTrackAnimateViewBaseAnimate *(^setTimingFunction)(MFTrackAnimateViewBaseAnimateTimingFunctionStyle style);

/**
 * 动画开始执行
 */
@property (nonatomic, copy) void(^didAnimateStartActionBlock)(CGPoint startPoint);

/**
 * 动画执行完毕
 */
@property (nonatomic, copy) void(^didAnimateStopActionBlock)(CGPoint stopPoint);

@end