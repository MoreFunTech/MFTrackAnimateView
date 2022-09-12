//
//  MFTrackAnimateView.m
//  Expecta
//
//  Created by Administer on 2022/8/5.
//

#import "MFTrackAnimateView.h"

@implementation MFTrackAnimateView

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame rotateCenterPoint:(CGPoint)rotateCenterPoint radius:(CGFloat)radius circleAngleList:(NSArray<NSNumber *> *)circleAngleList distanceCircleAngle:(double)distanceCircleAngle isDirectionClockwise:(BOOL)isDirectionClockwise dataSource:(id)dataSource {
    return [self rotateExpandViewWithFrame:frame rotateCenterPoint:rotateCenterPoint radius:radius delay:0 circleAngleList:circleAngleList distanceCircleAngle:distanceCircleAngle isDirectionClockwise:isDirectionClockwise dataSource:dataSource selectActionBlock:^(NSUInteger selectIndex) {}];
}

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame rotateCenterPoint:(CGPoint)rotateCenterPoint radius:(CGFloat)radius delay:(NSTimeInterval)delay circleAngleList:(NSArray<NSNumber *> *)circleAngleList distanceCircleAngle:(double)distanceCircleAngle isDirectionClockwise:(BOOL)isDirectionClockwise dataSource:(id)dataSource selectActionBlock:(void (^)(NSUInteger))selectActionBlock {
    MFTrackAnimateViewRotateExpandView *view = [[MFTrackAnimateViewRotateExpandView alloc] initWithFrame:frame];
    view.configureModel.rotateCenterPoint = rotateCenterPoint;
    view.configureModel.radius = radius;
    view.configureModel.circleAngleList = circleAngleList;
    view.configureModel.delay = delay;
    view.configureModel.distanceCircleAngle = distanceCircleAngle;
    view.configureModel.isDirectionClockwise = isDirectionClockwise;
    view.dataSource = dataSource;
    view.selectActionBlock = selectActionBlock;
    return view;
}

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel dataSource:(id)dataSource selectActionBlock:(void (^)(NSUInteger))selectActionBlock {
    MFTrackAnimateViewRotateExpandView *view = [[MFTrackAnimateViewRotateExpandView alloc] initWithFrame:frame];
    view.configureModel = configureModel;
    view.dataSource = dataSource;
    view.selectActionBlock = selectActionBlock;
    return view;
}

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel dataSource:(id)dataSource {
    return [self rotateExpandViewWithFrame:frame configureModel:configureModel dataSource:dataSource selectActionBlock:^(NSUInteger selectIndex) { }];
}


@end
