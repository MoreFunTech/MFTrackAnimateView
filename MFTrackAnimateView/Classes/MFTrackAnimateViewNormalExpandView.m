//
// Created by Neal on 2022/9/13.
//

#import "MFTrackAnimateViewNormalExpandView.h"
#import "MFTrackAnimateViewPoint.h"
#import "MFTrackAnimateViewBasePath.h"
#import "MFTrackAnimateViewEnum.h"
#import "MFTrackAnimateViewDemoItem.h"
#import "MFTrackAnimateViewBaseAnimate.h"

@interface MFTrackAnimateViewNormalExpandView ()

@property(nonatomic, strong) NSMutableArray <__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *> *itemList;
@property(nonatomic, strong) NSMutableArray <MFTrackAnimateViewBasePathConfigureModel *> *pathConfigureList;

@end

@implementation MFTrackAnimateViewNormalExpandView { }


- (void)reloadAnimate {

    for (int i = 0; i < self.itemList.count; ++i) {
        MFTrackAnimateViewBasePathConfigureModel *pathConfigureModel = self.pathConfigureList[(NSUInteger) i];
        UIBezierPath *movePath = [MFTrackAnimateViewBasePath pathWithPathConfigureModel:pathConfigureModel];
        UIView *item = self.itemList[i];
        [item.layer removeAllAnimations];
        MFTrackAnimateViewBaseAnimate *itemAnimate = MFTrackAnimateViewBaseAnimate.defaultAnimate
                .setDuring(pathConfigureModel.during)
                .setPath(movePath)
                .setRemoveOnComplete(YES)
                .setFillMode(MFTrackAnimateViewBaseAnimateFillModeStyleForwards)
                .setRepeatCount(1)
                .setDelay(pathConfigureModel.delay)
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
    [self.pathConfigureList removeAllObjects];
    if (![self.dataSource respondsToSelector:@selector(numberOfItemTrackView)]) {
        return;
    }

    NSUInteger totalCount = [self.dataSource numberOfItemTrackView];

    for (int i = 0; i <totalCount; i++) {
        CGSize size = CGSizeMake(30, 30);
        MFTrackAnimateViewBasePathConfigureModel *pathConfigureModel = [[MFTrackAnimateViewBasePathConfigureModel alloc] init];
        if ([self.dataSource respondsToSelector:@selector(pathConfigureForRowIndex: originPathConfigure:)]) {
            pathConfigureModel = [self.dataSource pathConfigureForRowIndex:i originPathConfigure:pathConfigureModel];
        }
        [self.pathConfigureList addObject:pathConfigureModel];
        __kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *item = [[MFTrackAnimateViewDemoItem alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        if ([self.dataSource respondsToSelector:@selector(sizeForRowAtIndex:)]) {
            size = [self.dataSource sizeForRowAtIndex:(NSUInteger) i];
        }
        if ([self.dataSource respondsToSelector:@selector(itemForRowAtIndex:)]) {
            item = [self.dataSource itemForRowAtIndex:(NSUInteger) i];
        }
        item.frame = CGRectMake(pathConfigureModel.startPoint.x - size.width / 2.0, pathConfigureModel.startPoint.y - size.height / 2.0, size.width, size.height);
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
    for (int i = 0; i < self.itemList.count; ++i) {
        MFTrackAnimateViewBasePathConfigureModel *pathConfigureModel = self.pathConfigureList[(NSUInteger) i].backPathConfigure;
        UIBezierPath *movePath = [MFTrackAnimateViewBasePath pathWithPathConfigureModel:pathConfigureModel];
        UIView *item = self.itemList[i];
        [item.layer removeAllAnimations];
        MFTrackAnimateViewBaseAnimate *itemAnimate = MFTrackAnimateViewBaseAnimate.defaultAnimate
                .setDuring(pathConfigureModel.dismissDuring)
                .setPath(movePath)
                .setRemoveOnComplete(YES)
                .setFillMode(MFTrackAnimateViewBaseAnimateFillModeStyleForwards)
                .setRepeatCount(1)
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
    return 77000;
}

- (NSMutableArray<__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate> *> *)itemList {
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

- (NSMutableArray<MFTrackAnimateViewBasePathConfigureModel *> *)pathConfigureList {
    if (!_pathConfigureList) {
        _pathConfigureList = [NSMutableArray array];
    }
    return _pathConfigureList;
}

@end