//
// Created by Neal on 2022/9/12.
//

#import <Foundation/Foundation.h>

@protocol MFTrackAnimateViewRotateExpandViewDataSource;


@interface MFTrackAnimateViewRotateExpandViewConfigureModel: NSObject

/**
 * 动画延迟开始时间
 */
@property(nonatomic) NSTimeInterval delay;

/**
 * 动画时长
 */
@property(nonatomic) NSTimeInterval during;

/**
 * 关闭动画时长
 */
@property(nonatomic) NSTimeInterval dismissDuring;

/**
 * 旋转中心店
 */
@property(nonatomic) CGPoint rotateCenterPoint;

/**
 * 旋转半径
 */
@property(nonatomic) CGFloat radius;

/**
 * 旋转终点位置 (角度)
 */
@property(nonatomic, strong) NSArray<NSNumber *> *circleAngleList;

/**
 * 旋转距离（角度）
 */
@property(nonatomic) double distanceCircleAngle;

/**
 * 是否顺时针旋转
 */
@property(nonatomic) BOOL isDirectionClockwise;

+ (instancetype)defaultConfigure;

@end

@interface MFTrackAnimateViewRotateExpandView : UIView

/**
 * 配置模型
 */
@property (nonatomic, strong) MFTrackAnimateViewRotateExpandViewConfigureModel *configureModel;

/**
 * 数据源代理
 */
@property(nonatomic, weak) id<MFTrackAnimateViewRotateExpandViewDataSource> dataSource;

/**
 * 点击事件（与代理里的select实现一个就好）
 */
@property(nonatomic, copy) void (^selectActionBlock)(NSUInteger);

/**
 * 动画执行完毕
 */
@property(nonatomic, copy) void (^didAnimateStopBlock)(BOOL isShowAnimate);

/**
 * 配置视图
 */
- (void)configureSubviews;

/**
 * 消失动画 反向动画
 */
- (void)dismissAction;

/**
 * 出现动画
 */
- (void)showAction;

@end