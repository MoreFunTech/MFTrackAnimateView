//
// Created by Neal on 2022/9/12.
//

#import <Foundation/Foundation.h>

@class MFTrackAnimateViewBasePathConfigureModel;

@protocol MFTrackAnimateViewRotateExpandViewItemDelegate <NSObject>

- (void)destroyItem;

- (void)configureSubviews;

@end

@protocol MFTrackAnimateViewRotateExpandViewDataSource <NSObject>

- (__kindof UIView <MFTrackAnimateViewRotateExpandViewItemDelegate>*)itemForRowAtIndex:(NSUInteger)index;

- (CGSize)sizeForRowAtIndex:(NSUInteger)index;

@optional
- (void)didItemSelectWithIndex:(NSUInteger)index;

@optional
- (MFTrackAnimateViewBasePathConfigureModel *)pathConfigureForRowIndex:(NSUInteger)index originPathConfigure:(MFTrackAnimateViewBasePathConfigureModel *)originPathConfigure;

@optional
- (NSUInteger)numberOfItemTrackView;



@end