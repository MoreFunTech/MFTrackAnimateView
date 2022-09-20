//
// Created by Neal on 2022/9/13.
//

#import <Foundation/Foundation.h>

@protocol MFTrackAnimateViewRotateExpandViewDataSource;
@class MFTrackAnimateViewPoint;
@class MFTrackAnimateViewBasePathConfigureModel;

@interface MFTrackAnimateViewNormalExpandView : UIView

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