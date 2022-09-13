//
// Created by Neal on 2022/9/12.
//

#import "MFTrackAnimateViewRotateExpandView.h"
#import "MFTrackAnimateViewBasePath.h"
#import "MFTrackAnimateViewBaseAnimate.h"
#import "MFTrackAnimateViewEnum.h"
#import "MFTrackAnimateViewDemoItem.h"

@implementation MFTrackAnimateViewRotateExpandViewConfigureModel {

}

+ (instancetype)defaultConfigure {
    MFTrackAnimateViewRotateExpandViewConfigureModel *model = [[MFTrackAnimateViewRotateExpandViewConfigureModel alloc] init];
    model.delay = 0;
    model.radius = 50;
    model.during = 1;
    model.dismissDuring = 0.5;
    model.rotateCenterPoint = CGPointZero;
    model.radius = 0;
    model.circleAngleList = @[];
    model.distanceCircleAngle = 0;
    model.isDirectionClockwise = NO;
    return model;
}

@end

@interface MFTrackAnimateViewRotateExpandView ()

@property(nonatomic, strong) NSMutableArray <__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *> *itemList;

@end


@implementation MFTrackAnimateViewRotateExpandView {

}

- (void)reloadAnimate {

    for (int i = 0; i < self.configureModel.circleAngleList.count; ++i) {
        double angle = self.configureModel.circleAngleList[i].doubleValue;
        double startCircleAngle = 0;
        double startAngle = 360 - startCircleAngle - angle;
        double stopAngle = startAngle - self.configureModel.distanceCircleAngle;
        if (self.configureModel.isDirectionClockwise) {
            stopAngle = startAngle + self.configureModel.distanceCircleAngle;
        }
        double centerPointX = self.configureModel.rotateCenterPoint.x + sin((startAngle + 270) / 360.0 * M_PI * 2) * self.configureModel.radius;
        double centerPointY = self.configureModel.rotateCenterPoint.y - cos((startAngle + 270) / 360.0 * M_PI * 2) * self.configureModel.radius;
        UIBezierPath *movePath = [MFTrackAnimateViewBasePath circlePathWithCenterPoint:CGPointMake(centerPointX, centerPointY) radius:self.configureModel.radius startCircleAngle:startAngle stopCircleAngle:stopAngle isDirectionClockwise:self.configureModel.isDirectionClockwise];
        UIView *item = self.itemList[i];
        [item.layer removeAllAnimations];
        MFTrackAnimateViewBaseAnimate *itemAnimate = MFTrackAnimateViewBaseAnimate.defaultAnimate
                .setDuring(self.configureModel.during)
                .setPath(movePath)
                .setRemoveOnComplete(YES)
                .setFillMode(MFTrackAnimateViewBaseAnimateFillModeStyleForwards)
                .setRepeatCount(1)
                .setDelay(self.configureModel.delay)
                .setTimingFunction(MFTrackAnimateViewBaseAnimateTimingFunctionStyleLiner);
        __weak typeof(self) weakSelf = self;
        itemAnimate.didAnimateStopActionBlock = ^(CGPoint point) {
            [weakSelf animateDidStopWithIndex:i point:point];
            if (i == 0) {
                if (weakSelf.didAnimateStopBlock) {
                    weakSelf.didAnimateStopBlock(YES);
                }
            }
        };
        [item.layer addAnimation:itemAnimate.animate forKey:[NSString stringWithFormat:@"animate%d", i]];
    }
}

- (void)animateDidStopWithIndex:(int)index point:(CGPoint)point {
    if (self.itemList.count > index) {
        UIView *item = self.itemList[(NSUInteger) index];
        CGRect originRect = item.frame;
        self.itemList[(NSUInteger) index].frame = CGRectMake(point.x - originRect.size.width / 2.0, point.y - originRect.size.height / 2.0, originRect.size.width, originRect.size.height);
    }
}

- (void)configureSubviews {
    [self.itemList enumerateObjectsUsingBlock:^(__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *obj, NSUInteger idx, BOOL *stop) {
        [obj destroyItem];
        [obj removeFromSuperview];
    }];
    for (int i = 0; i < self.configureModel.circleAngleList.count; i++) {
        CGSize size = CGSizeMake(30, 30);
        __kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *item = [[MFTrackAnimateViewDemoItem alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        if ([self.dataSource respondsToSelector:@selector(sizeForRowAtIndex:)]) {
            size = [self.dataSource sizeForRowAtIndex:(NSUInteger) i];
        }
        if ([self.dataSource respondsToSelector:@selector(itemForRowAtIndex:)]) {
            item = [self.dataSource itemForRowAtIndex:(NSUInteger) i];
        }
        item.frame = CGRectMake(self.configureModel.rotateCenterPoint.x - size.width / 2.0, self.configureModel.rotateCenterPoint.y - size.height / 2.0, size.width, size.height);
        item.userInteractionEnabled = YES;
        item.tag = self.tagBase + i;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemSelectAction:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [item addGestureRecognizer:tapGestureRecognizer];
        [item configureSubviews];
        [self addSubview:item];
        [self.itemList addObject:item];
    }
    [self reloadAnimate];
}

- (void)dismissAction {
    for (int i = 0; i < self.configureModel.circleAngleList.count; ++i) {
        double angle = self.configureModel.circleAngleList[i].doubleValue;
        double startCircleAngle = 0;
        double stopAngle = 360 - startCircleAngle - angle;
        double startAngle = stopAngle - self.configureModel.distanceCircleAngle;
        if (self.configureModel.isDirectionClockwise) {
            stopAngle = startAngle + self.configureModel.distanceCircleAngle;
        }
        double centerPointX = self.configureModel.rotateCenterPoint.x + sin((stopAngle + 270) / 360.0 * M_PI * 2) * self.configureModel.radius;
        double centerPointY = self.configureModel.rotateCenterPoint.y - cos((stopAngle + 270) / 360.0 * M_PI * 2) * self.configureModel.radius;
        UIBezierPath *movePath = [MFTrackAnimateViewBasePath circlePathWithCenterPoint:CGPointMake(centerPointX, centerPointY) radius:self.configureModel.radius startCircleAngle:startAngle stopCircleAngle:stopAngle isDirectionClockwise:!self.configureModel.isDirectionClockwise];
        UIView *item = self.itemList[i];
        [item.layer removeAllAnimations];
        MFTrackAnimateViewBaseAnimate *itemAnimate = MFTrackAnimateViewBaseAnimate.defaultAnimate
                .setDuring(self.configureModel.dismissDuring)
                .setPath(movePath)
                .setRemoveOnComplete(YES)
                .setFillMode(MFTrackAnimateViewBaseAnimateFillModeStyleForwards)
                .setRepeatCount(1)
                .setDelay(0)
                .setTimingFunction(MFTrackAnimateViewBaseAnimateTimingFunctionStyleLiner);
        __weak typeof(self) weakSelf = self;
        itemAnimate.didAnimateStopActionBlock = ^(CGPoint point) {
            [weakSelf animateDidStopWithIndex:i point:point];
            if (i == 0) {
                if (weakSelf.didAnimateStopBlock) {
                    weakSelf.didAnimateStopBlock(NO);
                }
            }
        };
        [item.layer addAnimation:itemAnimate.animate forKey:[NSString stringWithFormat:@"animate%d", i]];
    }
}

- (void)showAction {
    [self reloadAnimate];
}


- (void)itemSelectAction:(UIGestureRecognizer *)gestureRecognizer {
    NSInteger tag = gestureRecognizer.view.tag;
    NSInteger index = tag - self.tagBase;
    if ([self.dataSource respondsToSelector:@selector(didItemSelectWithIndex:)]) {
        [self.dataSource didItemSelectWithIndex:(NSUInteger) index];
    }
    if (self.selectActionBlock) {
        self.selectActionBlock((NSUInteger) index);
    }
}

//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [self configureSubviews];
//}

- (NSInteger)tagBase {
    return 76000;
}

- (NSMutableArray<__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *> *)itemList {
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

- (MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel {
    if (!_configureModel) {
        _configureModel = MFTrackAnimateViewRotateExpandViewConfigureModel.defaultConfigure;
    }
    return _configureModel;
}

@end