//
// Created by Neal on 2022/9/11.
//

#import <Foundation/Foundation.h>

@interface MFTrackAnimateViewBasePath : NSObject

/**
 * 快速构建贝塞尔曲线
 * @param startPoint 路径起点
 * @param endPoint 路径终点
 * @param anchorPoint 偏移点
 * @return 贝塞尔路径
 */
+ (UIBezierPath *)bezierPathWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                               anchorPoint:(CGPoint)anchorPoint;

/**
 * 快速构建贝塞尔曲线
 * @param startPoint 路径起点
 * @param endPoint 路径终点
 * @param anchorPoint1 偏移点1
 * @param anchorPoint2 偏移点2
 * @return 贝塞尔路径
 */
+ (UIBezierPath *)bezierPathWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                               anchorPoint1:(CGPoint)anchorPoint1
                               anchorPoint2:(CGPoint)anchorPoint2;

/**
 * 快速构建圆弧曲线
 * @param centerPoint 圆心
 * @param radius 半径
 * @param startCircleAngle
 * @param stopCircleAngle
 * @param isDirectionClockwise
 * @return
 */
+ (UIBezierPath *)circlePathWithCenterPoint:(CGPoint)centerPoint
                                     radius:(CGFloat)radius
                           startCircleAngle:(CGFloat)startCircleAngle
                            stopCircleAngle:(CGFloat)stopCircleAngle
                       isDirectionClockwise:(BOOL)isDirectionClockwise;

@end