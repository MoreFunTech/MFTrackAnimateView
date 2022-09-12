//
//  MFTrackAnimateView.h
//  Expecta
//
//  Created by Administer on 2022/8/5.
//

#import <UIKit/UIKit.h>


#import "MFTrackAnimateViewHeader.h"

NS_ASSUME_NONNULL_BEGIN


@interface MFTrackAnimateView : UIView

/**
 * 快速生成旋转放大轨道动画
 * @param frame 尺寸
 * @param rotateCenterPoint 旋转中心点
 * @param radius 旋转半径
 * @param circleAngleList 旋转起始点位置
 * @param distanceCircleAngle 旋转幅度
 * @param isDirectionClockwise 是否顺时针旋转
 * @param dataSource 数据源代理
 * @return
 */
+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                rotateCenterPoint:(CGPoint)rotateCenterPoint
                                                           radius:(CGFloat)radius
                                                  circleAngleList:(NSArray <NSNumber *> *)circleAngleList
                                              distanceCircleAngle:(double)distanceCircleAngle
                                             isDirectionClockwise:(BOOL)isDirectionClockwise
                                                       dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource;

/**
 * 快速生成旋转放大轨道动画
 * @param frame 尺寸
 * @param rotateCenterPoint 旋转中心点
 * @param radius 旋转半径
 * @param delay 动画延迟开始执行
 * @param circleAngleList 旋转起始点位置
 * @param distanceCircleAngle 旋转幅度
 * @param isDirectionClockwise 是否顺时针旋转
 * @param dataSource 数据源代理
 * @param selectActionBlock 选择回调
 * @return
 */
+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                rotateCenterPoint:(CGPoint)rotateCenterPoint
                                                           radius:(CGFloat)radius
                                                           delay:(NSTimeInterval)delay
                                                  circleAngleList:(NSArray <NSNumber *> *)circleAngleList
                                              distanceCircleAngle:(double)distanceCircleAngle
                                             isDirectionClockwise:(BOOL)isDirectionClockwise
                                                       dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource
                                                selectActionBlock:(void(^)(NSUInteger selectIndex))selectActionBlock;

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                   configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel
                                                       dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource
                                                selectActionBlock:(void(^)(NSUInteger selectIndex))selectActionBlock;

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                   configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel
                                                       dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource;






@end

NS_ASSUME_NONNULL_END
