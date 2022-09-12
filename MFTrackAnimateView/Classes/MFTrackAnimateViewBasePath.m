//
// Created by Neal on 2022/9/11.
//

#import "MFTrackAnimateViewBasePath.h"


@implementation MFTrackAnimateViewBasePath {

}

+ (UIBezierPath *)bezierPathWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                               anchorPoint:(CGPoint)anchorPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:anchorPoint];
    return path;
}

+ (UIBezierPath *)bezierPathWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint
                              anchorPoint1:(CGPoint)anchorPoint1
                              anchorPoint2:(CGPoint)anchorPoint2 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addCurveToPoint:endPoint controlPoint1:anchorPoint1 controlPoint2:anchorPoint2];
    return path;
}

+ (UIBezierPath *)circlePathWithCenterPoint:(CGPoint)centerPoint
                                     radius:(CGFloat)radius
                           startCircleAngle:(CGFloat)startCircleAngle
                            stopCircleAngle:(CGFloat)stopCircleAngle
                       isDirectionClockwise:(BOOL)isDirectionClockwise {

    CGFloat startAngle = startCircleAngle / 360.0 * M_PI * 2;
    CGFloat endAngle = stopCircleAngle / 360.0 * M_PI * 2;
    double startPointX = sin(startAngle + M_PI_2) * radius + centerPoint.x;
    double startPointY = cos(startAngle + M_PI_2) * radius + centerPoint.y;

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(startPointX, startPointY);
//    [path moveToPoint:startPoint];
    [path addArcWithCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle clockwise:isDirectionClockwise];
    return path;
}


@end