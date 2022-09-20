//
// Created by Neal on 2022/9/11.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MFTrackAnimateViewBasePathConfigureModelPathStyle) {

    /**
     * 直线
     */
    MFTrackAnimateViewBasePathConfigureModelPathStyleLiner = 0,

    /**
     * 单锚点贝塞尔曲线
     */
    MFTrackAnimateViewBasePathConfigureModelPathStyleAnchorPointBezier = 1,

    /**
     * 双锚点贝塞尔曲线
     */
    MFTrackAnimateViewBasePathConfigureModelPathStyleDoubleAnchorPointBezier = 2,

    /**
     * 圆曲线路径
     */
    MFTrackAnimateViewBasePathConfigureModelPathStyleCircle = 3,
};

@interface MFTrackAnimateViewBasePathConfigureModel: NSObject <NSCopying>

@property (nonatomic, assign) MFTrackAnimateViewBasePathConfigureModelPathStyle pathStyle;

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

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint stopPoint;

@property (nonatomic) CGPoint anchorPoint0;

@property (nonatomic) CGPoint anchorPoint1;

@property (nonatomic) CGPoint centerPoint;

@property (nonatomic) CGFloat radius;

@property (nonatomic) CGFloat startCircleAngle;

@property (nonatomic) CGFloat stopCircleAngle;

@property (nonatomic) BOOL isDirectionClockwise;

- (MFTrackAnimateViewBasePathConfigureModel *)backPathConfigure;

- (id)copyWithZone:(NSZone *)zone;

@end

@interface MFTrackAnimateViewBasePath : NSObject

/**
 * 快速构建直线
 * @param startPoint 路径起点
 * @param endPoint 路径终点
 * @return 贝塞尔路径
 */
+ (UIBezierPath *)linePathWithStartPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint;

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

+ (UIBezierPath *)pathWithPathConfigureModel:(MFTrackAnimateViewBasePathConfigureModel *)pathConfigureModel;

@end