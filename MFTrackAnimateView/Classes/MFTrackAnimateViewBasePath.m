//
// Created by Neal on 2022/9/11.
//

#import "MFTrackAnimateViewBasePath.h"


@implementation MFTrackAnimateViewBasePathConfigureModel {
}

/**
 *
@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint stopPoint;

@property (nonatomic) CGPoint anchorPoint0;

@property (nonatomic) CGPoint anchorPoint1;

@property (nonatomic) CGPoint centerPoint;

@property (nonatomic) CGFloat radius;

@property (nonatomic) CGFloat startCircleAngle;

@property (nonatomic) CGFloat stopCircleAngle;

@property (nonatomic) BOOL isDirectionClockwise;
 */

- (MFTrackAnimateViewBasePathConfigureModel *)backPathConfigure {
    MFTrackAnimateViewBasePathConfigureModel *copyModel = self.copy;
    CGPoint startPoint = self.startPoint;
    CGPoint stopPoint = self.stopPoint;
    CGFloat startCircleAngle = self.startCircleAngle;
    CGFloat stopCircleAngle = self.stopCircleAngle;
    BOOL isDirectionClockwise = self.isDirectionClockwise;

    copyModel.startPoint = stopPoint;
    copyModel.stopPoint = startPoint;

    copyModel.startCircleAngle = stopCircleAngle;
    copyModel.stopCircleAngle = startCircleAngle;
    copyModel.isDirectionClockwise = !isDirectionClockwise;

    return copyModel;
}

- (id)copyWithZone:(NSZone *)zone {
    MFTrackAnimateViewBasePathConfigureModel *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.pathStyle = self.pathStyle;
        copy.delay = self.delay;
        copy.during = self.during;
        copy.dismissDuring = self.dismissDuring;
        copy.startPoint = self.startPoint;
        copy.stopPoint = self.stopPoint;
        copy.anchorPoint0 = self.anchorPoint0;
        copy.anchorPoint1 = self.anchorPoint1;
        copy.centerPoint = self.centerPoint;
        copy.radius = self.radius;
        copy.startCircleAngle = self.startCircleAngle;
        copy.stopCircleAngle = self.stopCircleAngle;
        copy.isDirectionClockwise = self.isDirectionClockwise;
    }

    return copy;
}


@end

@implementation MFTrackAnimateViewBasePath {

}


+ (UIBezierPath *)linePathWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    return path;
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
    [path addArcWithCenter:centerPoint radius:radius startAngle:startAngle endAngle:endAngle clockwise:isDirectionClockwise];
    return path;
}

+ (UIBezierPath *)pathWithPathConfigureModel:(MFTrackAnimateViewBasePathConfigureModel *)pathConfigureModel {
    if (pathConfigureModel.pathStyle == MFTrackAnimateViewBasePathConfigureModelPathStyleLiner) {
        return [MFTrackAnimateViewBasePath linePathWithStartPoint:pathConfigureModel.startPoint endPoint:pathConfigureModel.stopPoint];
    } else if (pathConfigureModel.pathStyle == MFTrackAnimateViewBasePathConfigureModelPathStyleAnchorPointBezier) {
        return [MFTrackAnimateViewBasePath bezierPathWithStartPoint:pathConfigureModel.startPoint endPoint:pathConfigureModel.stopPoint anchorPoint:pathConfigureModel.anchorPoint0];
    } else if (pathConfigureModel.pathStyle == MFTrackAnimateViewBasePathConfigureModelPathStyleDoubleAnchorPointBezier) {
        return [MFTrackAnimateViewBasePath bezierPathWithStartPoint:pathConfigureModel.startPoint endPoint:pathConfigureModel.stopPoint anchorPoint1:pathConfigureModel.anchorPoint0 anchorPoint2:pathConfigureModel.anchorPoint1];
    } else if (pathConfigureModel.pathStyle == MFTrackAnimateViewBasePathConfigureModelPathStyleCircle) {
        return [MFTrackAnimateViewBasePath circlePathWithCenterPoint:pathConfigureModel.centerPoint radius:pathConfigureModel.radius startCircleAngle:pathConfigureModel.startCircleAngle stopCircleAngle:pathConfigureModel.stopCircleAngle isDirectionClockwise:pathConfigureModel.isDirectionClockwise];
    }
    return [MFTrackAnimateViewBasePath linePathWithStartPoint:pathConfigureModel.startPoint endPoint:pathConfigureModel.stopPoint];
};


@end